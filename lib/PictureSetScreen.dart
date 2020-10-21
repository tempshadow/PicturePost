import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class PictureSetScreen extends StatefulWidget {
  int postId;
  PictureSetScreen(this.postId);

  @override
  _State createState() => _State();
}

class _State extends State<PictureSetScreen> {
  File _image;
  final picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    print('Test');

    if(pickedFile != null && pickedFile.path != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.green,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {

            },
            child: Text("Upload Picture Set", style: TextStyle(
                color: Colors.green),),
          )
        ],
      ),
      body:
      ListView(
        children: <Widget>[
          Container(
            color: Colors.green,
            height: 25,
            child: Center(child: Text("North", style: TextStyle(
                color: Colors.white
            ),
            )
            ),
          ),
          Container(
              child: _image == null
                  ? FlatButton(child: Image(image: AssetImage(
                  'assets/tapForPicture.jpg'
              )), onPressed: getImage)
                  : FlatButton(child: Image.file(_image), onPressed: getImage)
          ),
          Container(
            color: Colors.green,
            height: 25,
            child: Center(child: Text("North East", style: TextStyle(
                color: Colors.white
            ),
            )
            ),
          ),
          FlatButton(
            onPressed: () {

            },
            child: Image(image: AssetImage(
                'assets/tapForPicture.jpg')),
          ),
          Container(
            color: Colors.green,
            height: 25,
            child: Center(child: Text("East", style: TextStyle(
                color: Colors.white
            ),
            )
            ),
          ),
          FlatButton(
            onPressed: () {

            },
            child: Image(image: AssetImage(
                'assets/tapForPicture.jpg')),
          ),
          Container(
            color: Colors.green,
            height: 25,
            child: Center(child: Text("South East", style: TextStyle(
                color: Colors.white
            ),
            )
            ),
          ),
          FlatButton(
            onPressed: () {

            },
            child: Image(image: AssetImage(
                'assets/tapForPicture.jpg')),
          ),
          Container(
            color: Colors.green,
            height: 25,
            child: Center(child: Text("South", style: TextStyle(
                color: Colors.white
            ),
            )
            ),
          ),
          FlatButton(
            onPressed: () {

            },
            child: Image(image: AssetImage(
                'assets/tapForPicture.jpg')),
          ),
          Container(
            color: Colors.green,
            height: 25,
            child: Center(child: Text("South West", style: TextStyle(
                color: Colors.white
            ),
            )
            ),
          ),
          FlatButton(
            onPressed: () {

            },
            child: Image(image: AssetImage(
                'assets/tapForPicture.jpg')),
          ),
          Container(
            color: Colors.green,
            height: 25,
            child: Center(child: Text("West", style: TextStyle(
                color: Colors.white
            ),
            )
            ),
          ),
          FlatButton(
            onPressed: () {

            },
            child: Image(image: AssetImage(
                'assets/tapForPicture.jpg')),
          ),
          Container(
            color: Colors.green,
            height: 25,
            child: Center(child: Text("North West", style: TextStyle(
                color: Colors.white
            ),
            )
            ),
          ),
          FlatButton(
            onPressed: () {

            },
            child: Image(image: AssetImage(
                'assets/tapForPicture.jpg')),
          ),
          Container(
            color: Colors.green,
            height: 25,
            child: Center(child: Text("Up", style: TextStyle(
                color: Colors.white
            ),
            )
            ),
          ),
          FlatButton(
            onPressed: () {

            },
            child: Image(image: AssetImage(
                'assets/tapForPicture.jpg')),
          ),
        ],
      ),
    );
  }

}