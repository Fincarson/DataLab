"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.customRecipeFlow = void 0;
const genkit_1 = require("genkit");
const retriever_1 = require("../retriever");
const config_1 = require("../config");
const vertexai_1 = require("@genkit-ai/vertexai");
const recipeGenerator = config_1.ai.definePrompt({
    model: vertexai_1.gemini15Flash,
    name: 'recipeGenerator',
    messages: `You are given an original recipe with ingredients and directions. Your task is to modify the recipe to fit the user's available ingredients while keeping the dish as close to the original as possible.

                Original Recipe:

                Title: {{suggestRecipe.title}}
                Ingredients: {{suggestRecipe.ingredients}}
                Directions: {{suggestRecipe.directions}}

                User's Available Ingredients: {{ingredients}}

                Requirements:
                - **Remove** ingredients that the user doesn't have, except for the basic ingredients such as oil or salt.
                - Suggest reasonable substitutions for missing ingredients.
                - Adjust the cooking steps accordingly.
                - Maintain the essence of the dish.

                Output format:
                - title: string, the modified recipe's name
                - ingredients: string, List of new ingredients based on the user's available items
                - directions: string, Modified step-by-step instructions`,
    input: {
        schema: genkit_1.z.object({
            suggestRecipe: genkit_1.z.object({
                title: genkit_1.z.string(),
                ingredients: genkit_1.z.string(),
                directions: genkit_1.z.string()
            }),
            ingredients: genkit_1.z.string()
        })
    }
});
exports.customRecipeFlow = config_1.ai.defineFlow({
    name: 'customRecipeFlow',
    inputSchema: genkit_1.z.string()
}, async (input) => {
    const recipes = await config_1.ai.run('Retrieve matching ingredients', async () => {
        try {
            const docs = await config_1.ai.retrieve({
                retriever: retriever_1.recipieRetriever,
                query: input,
                options: {
                    limit: 1,
                },
            });
            return docs.map((doc) => {
                const data = doc.toJSON();
                console.log(data);
                const recipe = {
                    title: '',
                    directions: '',
                    ingredients: '',
                    ...data.metadata,
                };
                delete recipe.ingredient_embedding;
                recipe.ingredients = data.content[0].text;
                return recipe;
            });
        }
        catch (error) {
            console.log(error);
            return [];
        }
    });
    const response = await recipeGenerator({
        suggestRecipe: recipes[0],
        ingredients: input
    });
    const customRecipe = response?.output;
    return customRecipe;
});
