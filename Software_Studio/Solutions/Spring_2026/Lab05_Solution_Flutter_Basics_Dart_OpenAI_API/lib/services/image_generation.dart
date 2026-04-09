import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class ImageGenerationService {
  static const String _apiKey = "YOUR_API_KEY"; // FIXME: Replace with your API key
  static const String _url = 'https://api.openai.com/v1/images/generations';

  Future<Map<String, dynamic>> generateImage(String prompt) async {
    // TODO: Complete the code
    final response = await http.post(
      Uri.parse(_url),
      headers: {
        "Authorization": "Bearer $_apiKey",
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode({
        "model": "gpt-image-1.5",
        "prompt": prompt,
      }),
    );

    final data = jsonDecode(response.body);

    if(response.statusCode == 200){
      final base64Decoder = base64Decode(data["data"][0]["b64_json"]);
      return {"success": true, "base64Decoder": base64Decoder,};
    } else {
      return {"success": false, "message": "Image not found in API response",};
    }
  }
}
