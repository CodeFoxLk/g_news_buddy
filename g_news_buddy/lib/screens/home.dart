import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:g_news_buddy/configs/theme/custom_text_styles.dart';
import 'package:g_news_buddy/models/article_model.dart';
import 'package:g_news_buddy/screens/screens.dart';
import 'package:g_news_buddy/widgets/common/image_blurhash.dart';
import 'package:provider/provider.dart';

import '../configs/theme/ui_parameters.dart';
import '../providers/article_provider.dart';

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
            Padding(
              padding: UIParameters.contentPadding,
              child: const Align(
                alignment: Alignment.bottomRight,
                child: Text("IGN News"),
              ),
            ),
            Expanded(
                child: NotificationListener<ScrollEndNotification>(
              onNotification: (t) {
                if (t.metrics.pixels > 0 && t.metrics.atEdge) {
                  final articleProvider = context.read<ArticleProvider>();
                  if(!articleProvider.isLoadingTextArticles && !articleProvider.isLoadingVideoArticles) {
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
                          return Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                borderRadius: UIParameters.cardBorderRadius),
                            height: 240,
                            width: double.maxFinite,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                    child: BlurHashImage(
                                        uri: articlesData.thumbnails[1].url!)),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    // alignment: Alignment.bottomCenter,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                          Colors.transparent,
                                          Theme.of(context)
                                              .scaffoldBackgroundColor
                                        ])),
                                    padding: const EdgeInsets.all(10.0),
                                    child: (articlesData.metadata != null)
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              if (articlesData
                                                      .metadata?.title !=
                                                  null)
                                                Text(
                                                  articlesData.metadata!.title!,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: kTitleTs.copyWith(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                              if (articlesData
                                                      .metadata?.description !=
                                                  null)
                                                Text(
                                                  articlesData
                                                      .metadata!.description!,
                                                  maxLines: 2,
                                                ),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                  articlesData
                                                      .metadata!.publishDate,
                                                  style: const TextStyle(
                                                      fontSize: 10))
                                            ],
                                          )
                                        : const SizedBox(),
                                  ),
                                ),
                                Positioned.fill(
                                    child: Material(
                                  type: MaterialType
                                      .transparency, // to show tapping ripple effect
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, ArticleScreen.route,
                                          arguments: articlesData);
                                    },
                                  ),
                                ))
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (b, i) => const SizedBox(
                          height: 25,
                        ),
                      ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
