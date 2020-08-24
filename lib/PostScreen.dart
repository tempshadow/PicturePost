import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PostScreen extends StatelessWidget{
  String name;
  PostScreen(String description) {
    this.name = description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text(this.name),
        leading: FlatButton(
          child: Row(
            children: [
              Icon(Icons.arrow_back_ios),
              Text("Back"),
            ],
          ),
            onPressed: () {Navigator.pop(context);},
        )
      ),
    );
  }
  
}