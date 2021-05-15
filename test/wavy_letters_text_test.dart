import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wobbling_letters_text/wavy_letters_text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget){
        return Home();
      },
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Center(
            child: WavyLettersText('Woah, it\'s chilly in here'),
          ),
        ));
  }
}

