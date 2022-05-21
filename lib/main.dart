import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wannaanime/application/application.dart';
import 'package:wannaanime/application/injector.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);

  runApp(
    const Injector(
      router: Application(),
    ),
  );
}
