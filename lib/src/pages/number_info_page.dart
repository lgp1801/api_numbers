import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class NumberInfoModel extends ChangeNotifier {
  String _numberInfoGetInfo = '';
  String _numberInfoRandom = '';

  ////ahdskalñdsjaksdljkasdkasdlkasldalnkds

  String get numberInfoGetInfo => _numberInfoGetInfo;
  String get numberInfoRandom => _numberInfoRandom;

  Future<void> fetchNumberInfo(int number, {bool isRandom = false}) async {
    try {
      final dio = Dio();
      final response = await dio.get('http://numbersapi.com/$number');
      if (response.statusCode == 200) {
        final info = response.data;
        if (isRandom) {
          _numberInfoRandom = info;
        } else {
          _numberInfoGetInfo = info;
        }
      } else {
        if (isRandom) {
          _numberInfoRandom = 'Error in request';
        } else {
          _numberInfoGetInfo = 'Error in request';
        }
      }
    } catch (error) {
      if (isRandom) {
        _numberInfoRandom = 'Error in request';
      } else {
        _numberInfoGetInfo = 'Error in request';
      }
    }
    notifyListeners();
  }
}

class NumberInfoPage extends StatefulWidget {
  @override
  _NumberInfoPageState createState() => _NumberInfoPageState();
}

class _NumberInfoPageState extends State<NumberInfoPage> {
  final TextEditingController _numberController = TextEditingController();

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  Future<void> fetchSpecificNumberInfo() async {
    final specificNumber = 18; // Specific number
    final numberInfoModel =
        Provider.of<NumberInfoModel>(context, listen: false);
    numberInfoModel.fetchNumberInfo(specificNumber);
  }

  Future<void> fetchRandomNumberInfo() async {
    final random = Random();
    final randomNumber =
        random.nextInt(100) + 1; // Generates a random number between 1 and 100
    final numberInfoModel =
        Provider.of<NumberInfoModel>(context, listen: false);
    numberInfoModel.fetchNumberInfo(randomNumber, isRandom: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number API'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _numberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter a number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final number = int.tryParse(_numberController.text);
                if (number != null) {
                  final numberInfoModel =
                      Provider.of<NumberInfoModel>(context, listen: false);
                  numberInfoModel.fetchNumberInfo(number);
                } else {
                  final snackBar = SnackBar(
                    content: Text('Enter a valid number'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: Text('Get info'),
            ),
            SizedBox(height: 32),
            Consumer<NumberInfoModel>(
              builder: (context, numberInfoModel, _) => Text(
                numberInfoModel.numberInfoGetInfo,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: fetchRandomNumberInfo,
              child: Text('Get info for a random number'),
            ),
            SizedBox(height: 32),
            Consumer<NumberInfoModel>(
              builder: (context, numberInfoModel, _) => Text(
                numberInfoModel.numberInfoRandom,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
