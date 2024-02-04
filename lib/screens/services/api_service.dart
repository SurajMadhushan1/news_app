import 'dart:convert';

import 'package:http/http.dart';
import 'package:news_app/screens/models/news_model.dart';

class ApiServices {
  String headLines =
      "https://newsapi.org/v2/top-headlines?country=us&apiKey=8fe7365632254e238105b07e4e3b959a";
  String bbcHeadlines =
      "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=8fe7365632254e238105b07e4e3b959a";
  String apiKey = "&apiKey=8fe7365632254e238105b07e4e3b959a";

  Future<List<NewsModel>?> getHeadlines() async {
    Response response = await get(Uri.parse(headLines));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      List<dynamic> articles = body['articles'];
      List<NewsModel> news =
          articles.map((news1) => NewsModel.fromjson(news1)).toList();
      return news;
    } else {
      throw response.statusCode;
    }
  }

  Future<List<NewsModel>?> getBBCHeadlines() async {
    Response response = await get(Uri.parse(bbcHeadlines));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      List<dynamic> articles = body['articles'];
      List<NewsModel> news =
          articles.map((news1) => NewsModel.fromjson(news1)).toList();
      return news;
    } else {
      throw response.statusCode;
    }
  }

  Future<List<NewsModel>?> getCatogeries(String catogory) async {
    String catogoryUrl =
        "https://newsapi.org/v2/top-headlines?q=$catogory&apiKey=8fe7365632254e238105b07e4e3b959a";
    Response response = await get(Uri.parse(catogoryUrl));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      List<dynamic> articles = body['articles'];
      List<NewsModel> news =
          articles.map((news1) => NewsModel.fromjson(news1)).toList();
      return news;
    } else {
      throw response.statusCode;
    }
  }
}
