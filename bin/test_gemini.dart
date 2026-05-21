import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  final _url = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=AIzaSyB6pbeOvSs_D4D3qyA8Baz1Ax5jOYT6IfU';
  
  final client = http.Client();
  final response = await client.post(
      Uri.parse(_url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "systemInstruction": {
          "parts": [
            {
              "text": "You are an expert news reporter who curates content and provides a brief to the point response in Pakistani Korangi slang Roman Urdu. You do not give long paragraphs but just some bullet points with the summary."
            }
          ]
        },
        "contents": [
          {
            "role": "user",
            "parts": [
              {
                "text": "Latest tech news summary in last 24 hours."
              }
            ]
          }
        ],
        "generationConfig": {
          "thinkingConfig": {
            "thinkingBudget": -1
          }
        },
        "tools": [
          {
            "googleSearch": {}
          }
        ]
      }),
    );

  print('Status code: ${response.statusCode}');
  print('Body: ${response.body}');
}
