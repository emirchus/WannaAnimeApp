import 'package:flutter/material.dart';
import 'package:wannaanime/presentation/screens/anime_screen.dart';
import 'package:wannaanime/presentation/screens/home_screen.dart';
import 'package:wannaanime/presentation/screens/splash_screen.dart';
import 'package:wannaanime/presentation/theme.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WannaAnime',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      restorationScopeId: "wannaanime",
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/anime': (context) => const AnimeScreen(),
      },
      builder: (context, child) {
        final mediaQueryData = MediaQuery.of(context);
        final scale = mediaQueryData.textScaleFactor.clamp(1.0, 1.3);

        return MediaQuery(
          child: child ?? Container(),
          data: MediaQuery.of(context).copyWith(textScaleFactor: scale),
        );
      },
    );
  }
}
