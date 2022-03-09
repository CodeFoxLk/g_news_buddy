import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../configs/theme/ui_parameters.dart';
import '../models/article_model.dart';
import '../providers/article_provider.dart';
import '../widgets/article/home_article_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String route = '/home';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Future.microtask(() => context.read<ArticleProvider>().loadAllArticles());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Expanded(
                child: NotificationListener<ScrollEndNotification>(
              onNotification: (t) {
                if (t.metrics.pixels > 0 && t.metrics.atEdge) {
                  final articleProvider = context.read<ArticleProvider>();
                  if (!articleProvider.isLoadingTextArticles &&
                      !articleProvider.isLoadingVideoArticles) {
                    articleProvider.loadAllArticles();
                  }
                } else {}
                return true;
              },
              child: Consumer<ArticleProvider>(
                builder: (_, articles, ___) => (articles.articles.isEmpty)
                    ? const SpinKitFadingCube(
                        color: Colors.white,
                      )
                    : ListView.separated(
                        itemCount: articles.articles.length,
                        padding: UIParameters.contentPadding.copyWith(top: 0),
                        itemBuilder: (b, i) {
                          ArticlesData articlesData = articles.articles[i];
                          return HomeArticleCard(articlesData: articlesData);
                        },
                        separatorBuilder: (b, i) => const SizedBox(
                          height: 25,
                        ),
                      ),
              ),
            )),
            Center(
              child: Consumer<ArticleProvider>(
                  builder: (_, articles, ___) => Visibility(
                      visible: articles.isLoadingTextArticles && articles.loadedRounds > 0,
                      child: const SpinKitFadingCube(
                        size: 20,
                        color: Colors.white,
                      ))),
            ),
            Padding(
                padding: UIParameters.contentPadding,
                child: Opacity(
                  opacity: 0.6,
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 11,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: const [
                        Text("All data from the IGN News Api"),
                        Text("https://ign-apis.herokuapp.com/")
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
