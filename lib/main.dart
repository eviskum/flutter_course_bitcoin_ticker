import 'package:flutter/material.dart';
import 'package:flutter_course_bitcoin_ticker/price_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(primaryColor: Colors.lightBlue, scaffoldBackgroundColor: Colors.white),
      home: PriceScreen(),
    );
  }
}
