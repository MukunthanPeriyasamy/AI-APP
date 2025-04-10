import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

Future<String> getData(String text) async {
  const endPoint = 'https://openrouter.ai/api/v1/chat/completions';

  final headers = {
    'Authorization':
        'Bearer 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',
    'Content-Type': 'application/json',
  };

  final body = convert.jsonEncode({
    'model': 'gpt-3.5-turbo',
    'messages': [
      {"role": "user", "content": text}
    ],
    'max_tokens': 100,
    'temperature': 0.7,
  });

  try {
    final response = await http.post(
      Uri.parse(endPoint),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      final choices = jsonResponse['choices'] as List<dynamic>;
      if (choices.isNotEmpty) {
        final firstChoice = choices.first as Map<String, dynamic>;
        final message = firstChoice['message'] as Map<String, dynamic>;
        return message['content'] as String? ?? 'No content';
      } else {
        return 'No choices available';
      }
    } else {
      return 'Request failed with status: ${response.statusCode}. Body: ${response.body}';
    }
  } catch (e) {
    return 'An error occurred: $e';
  }
}