import 'dart:convert';
import 'package:http/http.dart' as http;

String myApiKey = "2edce660aa862a74a57d4b2ec5fb93b0";
String myClientId = "17e58a61eee549c9c0f1090277599c28bf7d658e364aa3c15d02d475cfeb7e3";

class JDoodleApiService {
  final String clientId;
  final String apiKey;

  JDoodleApiService(this.clientId, this.apiKey);

  Future<String> sendCode(String code, String language) async {
    final url = Uri.parse('https://api.jdoodle.com/v1/execute');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'clientId': clientId,
      'clientSecret': apiKey,
      'script': code,
      'language': language,
      'versionIndex': '3',
      'stdin': '',
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        return decodedResponse['output'] ?? 'No output';
      } else {
        throw Exception('Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
