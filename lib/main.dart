import 'package:flutter/material.dart';
import 'package:numbers_api_project_job/src/pages/number_info_page.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => NumberInfoModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NumberInfoPage(),
    );
  }
}
