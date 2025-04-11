import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/article_model.dart';

class ApiService {
  final String apiKey = '821da28c8d42403e81fa1b8c165c7e86';

  Future<List<ArticleModel>> fetchArticles() async {
    final url = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> articlesJson = jsonData['articles'];

      return articlesJson.map((json) => ArticleModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load articles");
    }
  }
}
