import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/article_model.dart';

class ArticleService {
  String apiKey = "8d16b3f562fa465a93c1d810df7c6809";
  String baseUrl = "https://api-berita-indonesia.vercel.app";
  Future<List<ArticleModel>> getArticle({required String keyword}) async {
    var url = Uri.parse('$baseUrl/tribun/kesehatan');
    var headers = {'Content-Type': 'applicationjspn'};

    var response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['posts'];
      List<ArticleModel> articles = [];

      data.map(
        (article) {
          articles.add(ArticleModel.fromJson(article));
        },
      ).toList();

      return articles;
    } else {
      throw Exception('Gagal get artikel');
    }
  }
}
