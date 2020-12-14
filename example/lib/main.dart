import 'package:flutter/material.dart';
import 'package:translated_text/translated_text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp( title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: TranslatedText("I Love 'Flutter'.",to:'hi',),
          ),
        ),
      ),
    );
  }
}

