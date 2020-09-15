import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'LoadingPage.dart';
import 'MyAppState.dart';
import 'PostData.dart';


void main() {
  runApp(Start());
}


class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoadingPage(),
    );
  }
}

class MyApp extends StatefulWidget {
  final List<PostData> posts;
  MyApp({Key key, this.posts}) : super(key: key);
  @override
  MyAppState createState() => MyAppState();
}