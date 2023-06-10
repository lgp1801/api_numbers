import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class NumberInfoModerl extends ChangeNotifier {
  String? _numberInfo = '';
  String get numberInfo => _numberInfo!;

  Future<void> fetchNumberInfo(int number) async {
    final response = await http.get(Uri.parse('http://numbersapi.com/$number'));
    if (response.statusCode == 200) {
      _numberInfo = response.body;
    } else {
      notifyListeners();
    }
  }
}
