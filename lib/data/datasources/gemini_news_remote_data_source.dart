import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/news_item.dart';
import 'news_remote_data_source.dart';

class GeminiNewsRemoteDataSource implements NewsRemoteDataSource {
  final http.Client client;
  String get _url => 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=${dotenv.env["GEMINI_API_KEY"]}';

  GeminiNewsRemoteDataSource({http.Client? client}) : client = client ?? http.Client();

  @override
  Future<List<NewsItem>> fetchNews() async {
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

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final text = data['candidates'][0]['content']['parts'][0]['text'] as String;
      return _parseNews(text);
    } else {
      throw Exception('Failed to load Gemini news (${response.statusCode})');
    }
  }

  List<NewsItem> _parseNews(String rawText) {
    final List<NewsItem> news = [];
    final lines = rawText.split('\n').where((line) => line.trim().isNotEmpty).toList();

    for (final line in lines) {
      if (line.contains('**')) {
        final regex = RegExp(r'\*\*(.+?)\*\*');
        final match = regex.firstMatch(line);

        if (match != null) {
          final headline = match.group(1) ?? '';
          final body = line.replaceAll(regex, '').trim().replaceAll('*', '').trim();

          news.add(
            NewsItem(
              headline: headline,
              body: body.isEmpty ? 'Read more about this tech trend.' : body,
            ),
          );
        }
      } else if (line.startsWith('-') || line.startsWith('*')) {
        news.add(NewsItem(
          headline: 'Gemini Tech Update',
          body: line.replaceFirst(RegExp(r'^[-*]\s*'), '').trim(),
        ));
      }
    }

    if (news.isEmpty && rawText.isNotEmpty) {
      news.add(NewsItem(headline: 'Gemini News', body: rawText));
    }

    return news;
  }
}
