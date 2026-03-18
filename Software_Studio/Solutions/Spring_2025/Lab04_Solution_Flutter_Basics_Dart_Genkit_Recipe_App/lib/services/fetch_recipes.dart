import 'package:cloud_functions/cloud_functions.dart';

// TODO: calling your retrieveRecipeFlow
/* Hints:
  You can check how recipe_page.dart calling retrieveRecipeFlow.
  Note that the type of return value is crucial.
*/
Future<List<Map<String, dynamic>>> retrieveRecipes(Map<String, dynamic> ingredients) async {
  try {
    final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
      'retrieveRecipe',
    );

    final response = await callable.call(ingredients['ingredients']);

    final data = List<Map<String, dynamic>>.from(response.data);
    
    // final originRecipe = Map<String, dynamic>.from(data["originRecipe"]);
    return data;
  } catch (e) {
    print("Error fetching retrieved recipes: $e");
    throw Exception("Failed to fetch recipes");
  }
}
