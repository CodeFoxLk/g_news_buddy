import 'package:flutter/material.dart';
import 'package:g_news_buddy/providers/article_provider.dart';
import 'package:provider/provider.dart';

import 'configs/configs.dart';
import 'screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ArticleProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'G News Buddy',
        routes: {
          HomeScreen.route: (context) => const HomeScreen(),
          ArticleScreen.route: (context) => const ArticleScreen(),
        },
        darkTheme: DarkTheme().buildDarkTheme(context),
        theme: DarkTheme()
            .buildDarkTheme(context), //LightTheme().buildLightTheme(context),
        initialRoute: HomeScreen.route,
      ),
    );
  }
}
