import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course_bitcoin_ticker/coin_data.dart';
import 'dart:io' show Platform;

import 'package:flutter_course_bitcoin_ticker/crypto_service.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String? selectedCurrency = 'DKK';

  Map<String, String> exchangeRateTxt = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setInitialRateTxt();
  }

  void setInitialRateTxt() {
    setState(() {
      exchangeRateTxt.clear();
      for (String crypto in cryptoList) {
        exchangeRateTxt.addAll({crypto: '1 $crypto = ? ${selectedCurrency ?? '???'}'});
        // exchangeRateTxt.add('1 $crypto = ? ${selectedCurrency ?? '???'}');
      }
    });
  }

  void updatedRateTxt() {
    if (selectedCurrency == null) return;
    for (String crypto in cryptoList) {
      CryptoService.getExchangeRate(cryptoCurrency: crypto, realCurrency: selectedCurrency!).then((value) {
        if (value != null) {
          setState(() {
            exchangeRateTxt[crypto] = '1 $crypto = ${value.rate.toStringAsFixed(2)} ${selectedCurrency}';
          });
        }
      }).catchError((e) {
        print('Error getting exchange rate:');
        print(e);
      });
    }
  }

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

  List<Padding> generateExchangeRateList() {
    List<Padding> exchangeList = [];
    exchangeRateTxt.forEach((key, value) {
      exchangeList.add(ExchangeRateCard(value));
    });
    return exchangeList;
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
          ...generateExchangeRateList(),
          // ExchangeRateCard('1 BTC = ? USD'),
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

  Padding ExchangeRateCard(String rateTxt) {
    return Padding(
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
            rateTxt,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
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
        updatedRateTxt();
      },
      value: selectedCurrency,
    );
  }

  CupertinoPicker cupertinoCurrencyPicker() {
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (idx) {
        setState(() {
          selectedCurrency = currenciesList[idx];
        });
        updatedRateTxt();
      },
      children: generateCupertinoList(),
    );
  }
}
