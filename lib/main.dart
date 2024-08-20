import 'dart:io';

import 'package:flutter/material.dart';
import 'package:simap/res/app_router.dart';
import 'package:simap/view/app_screens/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({
    Key? key,
  }) : super(key: key);

  final AppRouter _appRoutes = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1)),
      child: MaterialApp(
        title: 'SIMAP',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: _appRoutes.onGenerateRoute,
        theme: ThemeData(),
        home: const SplashScreen(),
      ),
    );
  }
}
