import 'dart:convert';
import 'package:http/http.dart' as http;

class ImageGenerationService {
  static const String _apiKey =
      'YOUR_API_KEY'; // FIXME: Replace with your API key
  static const String _url = 'https://api.edenai.run/v2/image/generation';

  Future<Map<String, dynamic>> generateImage(String prompt) async {
    // TODO: Complete the code
    return {};
  }
}
