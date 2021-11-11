import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course_bitcoin_ticker/coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String? selectedCurrency = 'DKK';

  List<DropdownMenuItem<String>> generateCurrencyDropdownList() {
    List<DropdownMenuItem<String>> currencyList = [];
    for (var currency in currenciesList) {
      currencyList.add(DropdownMenuItem(child: Text(currency), value: currency));
    }
    return currencyList;
  }

  List<Text> generateCupertinoList() {
    List<Text> currencyList = [];
    for (var currency in currenciesList) {
      currencyList.add(Text(currency));
    }
    return currencyList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ? USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            // child: cupertinoCurrencyPicker(),
            child: Platform.isIOS ? cupertinoCurrencyPicker() : materialCurrencyDropdown(),
          ),
        ],
      ),
    );
  }

  DropdownButton<String> materialCurrencyDropdown() {
    return DropdownButton<String>(
      items: generateCurrencyDropdownList(),
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
        });
      },
      value: selectedCurrency,
    );
  }

  CupertinoPicker cupertinoCurrencyPicker() {
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (idx) {
        selectedCurrency = currenciesList[idx];
      },
      children: generateCupertinoList(),
    );
  }
}
