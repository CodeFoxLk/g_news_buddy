import 'package:flutter/material.dart';
import '../configs/theme/ui_parameters.dart';
import '../models/article_model.dart';
import '../widgets/widgets.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({Key? key}) : super(key: key);
  static const String route = '/article';
  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        _data = ModalRoute.of(context)?.settings.arguments as ArticlesData?;
      });
    });
  }

  ArticlesData? _data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (_data == null)
          ? const SizedBox()
          : CustomScrollView(
              slivers: <Widget>[
                if (_data!.metadata != null)
                  SliverAppBar(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    pinned: true,
                    expandedHeight: 200.0,
                    centerTitle: false,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: false,
                      expandedTitleScale: 1.4,
                      title: Text(_data!.metadata!.title!, textScaleFactor: 1, maxLines: 3, overflow: TextOverflow.ellipsis,),
                      //stretchModes: [],
                      titlePadding: UIParameters.contentPadding,
                      collapseMode: CollapseMode.pin,
                      background: Stack(
                        children: [
                          Positioned.fill(
                              child: BlurHashImage(
                                  uri: _data!.thumbnails[2].url!)),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              // alignment: Alignment.bottomCenter,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                    Colors.transparent,
                                    Theme.of(context).scaffoldBackgroundColor
                                  ])),
                              padding: const EdgeInsets.all(10.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: UIParameters.contentPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //  Text(_data!.metadata!.title ?? '',
                        //       style: const TextStyle(
                        //           fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 10),
                        Text(_data!.metadata!.publishDate),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: List.generate(
                                  _data!.authors.length,
                                  (index) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CircleAvatar(
                                              foregroundImage: _data!
                                                          .authors[index]
                                                          .thumbnail ==
                                                      null
                                                  ? null
                                                  : NetworkImage(_data!
                                                      .authors[index]
                                                      .thumbnail!),
                                              backgroundImage: const AssetImage(
                                                  'assets/images/dummy_profile_image.png'),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(_data!.authors[index].name ??
                                                '')
                                          ],
                                        ),
                                      )),
                            )),
                        Wrap(
                            spacing: 4.0,
                            runSpacing: 4.0,
                            children: List.generate(
                                _data!.tags.length,
                                (i) => Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 2),
                                      child: Text(
                                        _data!.tags[i],
                                        style: const TextStyle(fontSize: 10),
                                      ),
                                      decoration: const ShapeDecoration(
                                          shape: StadiumBorder(),
                                          color: Colors.red),
                                    ))),
                        const SizedBox(
                          height: 25,
                        ),
                        Text( _data!.metadata?.description ?? 'No Description'),
                        if(_data!.contentType == 'video')
                         Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: AriticleVideoPlayer(
                            videoUrl: (_data?.assets[0].url)!,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
