import 'package:cloud_functions/cloud_functions.dart';

// TODO: calling your customRecipeFlow
/* Hints:
  You can check how food_page.dart calling customRecipesFlow.
  Note that the type of return value is crucial.
*/
Future<Map<String, dynamic>> fetchCustomRecipe(String title, String ingredients, String directions, String addedIngredients) async {
  try {
    final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
      'customRecipe', // changed
    );

    final response = await callable.call({ // changed
      "title": title,
      "suggestRecipe": {
        "title": title,
        "ingredients": ingredients,
        "directions": directions,
      },
      "ingredients" : addedIngredients,
    });

    final data = Map<String, dynamic>.from(response.data as Map);
    final customRecipe = Map<String, dynamic>.from(data["recipe"]); // changed

    return { // changed
      "recipe": customRecipe,
      "customRecipeImage": {
        "url": data["customRecipeImage"]['message']['content'][0]['media']['url'],
      },
      "originRecipeImage": {
        "url": data["originRecipeImage"]['message']['content'][0]['media']['url'],
      },
    };
  } catch (e) {
    print("Error calling custom recipe: $e");
    throw Exception("Failed to fetch custom recipe");
  }
}
