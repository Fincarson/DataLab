import 'package:cloud_functions/cloud_functions.dart';

Future<Map<String, dynamic>> fetchCustomRecipe(String ingredients) async {
  try {
    final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
      'customRecipeExample',
    );

    final response = await callable.call(ingredients);

    final data = Map<String, dynamic>.from(response.data as Map);
    final customRecipe = Map<String, dynamic>.from(data["customRecipe"]);

    return customRecipe;
  } catch (e) {
    print("Error calling custom recipe: $e");
    throw Exception("Failed to fetch custom recipe");
  }
}
