import {onCallGenkit} from 'firebase-functions/https';

// TODO: export your functions
import './flow/customRecipe';
import { customRecipeFlow } from './flow/customRecipe';
import { retrieveRecipeFlow } from './flow/retrieveRecipe'; // added
export const retrieveRecipe = onCallGenkit(retrieveRecipeFlow); // added
export const customRecipe = onCallGenkit(customRecipeFlow);

