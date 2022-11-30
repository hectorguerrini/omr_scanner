import 'package:flutter/material.dart';
import 'package:omr_scanner/home.dart';
import 'package:omr_scanner/result.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ORM',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const HomePage());
          case '/result':
            return MaterialPageRoute(builder: (_) => const ResultPage());
          default:
            return MaterialPageRoute(builder: (_) => const HomePage());
        }
      },
      home: const HomePage(),
    );
  }
}
