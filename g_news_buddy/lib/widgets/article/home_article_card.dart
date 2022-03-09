
import 'package:flutter/material.dart';

import '../../configs/theme/custom_text_styles.dart';
import '../../configs/theme/ui_parameters.dart';
import '../../models/article_model.dart';
import '../../screens/article.dart';
import '../common/image_blurhash.dart';

class HomeArticleCard extends StatelessWidget {
  const HomeArticleCard({
    Key? key,
    required this.articlesData,
  }) : super(key: key);

  final ArticlesData articlesData;

  @override
  Widget build(BuildContext context) {
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
  }
}
