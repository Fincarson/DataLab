import 'package:cloud_functions/cloud_functions.dart';

Future<List<Map<String, dynamic>>> retrieveRecipes(String ingredients) async {
  try {
    final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
      'customRecipeExample',
    );

    final response = await callable.call(ingredients);

    final data = Map<String, dynamic>.from(response.data as Map);

    final originRecipe = Map<String, dynamic>.from(data["originRecipe"]);
    return [originRecipe];
  } catch (e) {
    print("Error fetching retrieved recipes: $e");
    throw Exception("Failed to fetch recipes");
  }
}
