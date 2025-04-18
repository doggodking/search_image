import 'package:flutter/material.dart';
import 'package:image_search_app/core/di/di_setup.dart';
import 'package:image_search_app/core/routing/router.dart';

void main() {
  diSetup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Search Image App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF4FB6B2)),
      ),
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
