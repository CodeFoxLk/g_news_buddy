import 'dart:convert';
import 'package:flutter/material.dart';

import '../models/article_model.dart';
import '../models/paginations_model.dart';
import '../services/net/end_points.dart';
import '../services/net/net.dart';

class ArticleProvider extends ChangeNotifier {
  List<ArticlesData> articles = [];

  int _loadedVideoArticlesRounds = 0;
  int _loadedTextRounds = 0;
  final _count = 5;

  int get loadedRounds => _loadedTextRounds + _loadedVideoArticlesRounds;

  bool isLoadingTextArticles = false;
  bool isLoadingVideoArticles = false;

  Future<void> loadAllArticles() async {
    final textArticles = await loadTextArticles();

    final videoArticles = await loadVideoArticles();

    final allArticles = [...textArticles, ...videoArticles];
    allArticles.shuffle();

    articles.addAll(allArticles);
    isLoadingTextArticles = false;
    isLoadingVideoArticles = false;
    _loadedVideoArticlesRounds = _loadedVideoArticlesRounds + 1;
    _loadedTextRounds = _loadedTextRounds + 1;
    notifyListeners();
  }

  Future<List<ArticlesData>> loadTextArticles() async {
    isLoadingTextArticles = true;
    notifyListeners();
    final net = Net.init(
        url: textArticlesEndPoint,
        queryParams: {
          "startIndex": "${1 + (_loadedTextRounds * _count)}",
          "count": "$_count"
        },
        httpMethod: HttpMethods.GET);

    net.onComplete = (r) {};

    net.onError = (e) {};

    final response = await net.execute();
    if (response == null) return [];
    final pagination = Pagination.fromJson(json.decode(response.body));

    return pagination.data;
    //print(response!.body);
  }

  Future<List<ArticlesData>> loadVideoArticles() async {
    isLoadingVideoArticles = true;
    notifyListeners();
    final net = Net.init(
        url: videoArticlesEndPoint,
        queryParams: {
          "startIndex": "${1 + (_loadedVideoArticlesRounds * _count)}",
          "count": "$_count"
        },
        httpMethod: HttpMethods.GET);

    net.onComplete = (r) {};

    net.onError = (e) {};

    final response = await net.execute();
    if (response == null) return [];
    final pagination = Pagination.fromJson(json.decode(response.body));

    return pagination.data;
  }
}
