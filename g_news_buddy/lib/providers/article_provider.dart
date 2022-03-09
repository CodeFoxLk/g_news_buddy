import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';

import '../models/article_model.dart';
import '../models/paginations_model.dart';
import '../services/net/end_points.dart';
import '../services/net/net.dart';

class ArticleProvider extends ChangeNotifier {
  List<ArticlesData> articles = [];

  int loadedVideoArticlesRounds = 0;
  int loadedRounds = 0;
  final count = 5;

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
    notifyListeners();
  }

  Future<List<ArticlesData>> loadTextArticles() async {
    isLoadingTextArticles = true;
    final net = Net.init(
        url: textArticlesEndPoint,
        queryParams: {
          "startIndex": "${1 + (loadedRounds * count)}",
          "count": "$count"
        },
        httpMethod: HttpMethods.GET);

    net.onComplete = (r) {
      loadedRounds = loadedRounds + 1;
    };

    net.onError = (e) {};

    final response = await net.execute();
    if(response == null) return [];
    final pagination = Pagination.fromJson(json.decode(response.body));

    return pagination.data;
    //print(response!.body);
  }

  Future<List<ArticlesData>> loadVideoArticles() async {
    isLoadingVideoArticles = true;
    final net = Net.init(
        url: videoArticlesEndPoint,
        queryParams: {
          "startIndex": "${1 + (loadedVideoArticlesRounds * count)}",
          "count": "$count"
        },
        httpMethod: HttpMethods.GET);

    net.onComplete = (r) {
      loadedVideoArticlesRounds = loadedVideoArticlesRounds + 1;
    };

    net.onError = (e) {};

    final response = await net.execute();
    if(response == null) return [];
    final pagination = Pagination.fromJson(json.decode(response.body));

    print( "${(loadedVideoArticlesRounds * count)}");

    return pagination.data;
  }
}
