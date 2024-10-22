import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:images/core/di/injection.dart';
import 'package:images/presentation/navigation/main_navigation.dart';

void main() {
  configureDependencies(env: const String.fromEnvironment('ENVIRONMENT'));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  
  final GoRouter router = getIt<MainNavigation>().router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      routerConfig: router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
