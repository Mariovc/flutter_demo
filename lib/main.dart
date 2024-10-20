import 'package:flutter/material.dart';
import 'package:images/core/di/injection.dart';
import 'package:images/presentation/widgets/pages/home_page.dart';

void main() {
  configureDependencies(env: const String.fromEnvironment('ENVIRONMENT'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
