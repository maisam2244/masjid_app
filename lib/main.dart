import 'package:flutter/material.dart';
import 'package:masjid_app/ApiServices/api_fetch.dart';
import 'package:masjid_app/ApiServices/test_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TestApp(),
    );
  }
}
