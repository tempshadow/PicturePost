import 'dart:io';
import 'package:Picturepost/TakePictureScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

// ignore: must_be_immutable
class PictureSetScreen extends StatefulWidget {
  int postId;
  List<String> paths;
  PictureSetScreen(this.postId, this.paths);

  @override
  _State createState() => _State();
}

class _State extends State<PictureSetScreen> {
  var cameras;
  var firstCamera;
  // Obtain a list of the available cameras on the device.
  Future<void> getCameras() async {
    cameras = await availableCameras();
    firstCamera = cameras.first;
  }

  // Get a specific camera from the list of available cameras.
      /*Future<void> retrieveLostData() async {
    final LostData response =
    await picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        if (response.type == RetrieveType.image) {
          _image = File(response.file.path);
        }
      });
    }
  }*/

  @override
  Widget build(BuildContext context) {
    //retrieveLostData();
    getCameras();
    return Scaffold (
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.green,
          onPressed: () {
            //change to pushreplace
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
              child: widget.paths[0] == ''
                  ? FlatButton(child: Image(image: AssetImage(
                  'assets/tapForPicture.jpg'
              )), onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TakePictureScreen(firstCamera,
                    widget.postId, 0, widget.paths),
                  ),
                );
              })
                  : FlatButton(child: Image.file(File(widget.paths[0])), onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TakePictureScreen(firstCamera,
                      widget.postId, 0, widget.paths),
                  ),
                );
              })
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
          Container(
              child: widget.paths[1] == ''
                  ? FlatButton(child: Image(image: AssetImage(
                  'assets/tapForPicture.jpg'
              )), onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TakePictureScreen(firstCamera,
                      widget.postId, 1, widget.paths),
                  ),
                );
              })
                  : FlatButton(child: Image.file(File(widget.paths[1])), onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TakePictureScreen(firstCamera,
                      widget.postId, 1, widget.paths),
                  ),
                );
              })
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
          Container(
              child: widget.paths[2] == ''
                  ? FlatButton(child: Image(image: AssetImage(
                  'assets/tapForPicture.jpg'
              )), onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TakePictureScreen(firstCamera,
                        widget.postId, 2, widget.paths),
                  ),
                );
              })
                  : FlatButton(child: Image.file(File(widget.paths[2])), onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TakePictureScreen(firstCamera,
                        widget.postId, 2, widget.paths),
                  ),
                );
              })
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
          Container(
              child: widget.paths[3] == ''
                  ? FlatButton(child: Image(image: AssetImage(
                  'assets/tapForPicture.jpg'
              )), onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TakePictureScreen(firstCamera,
                        widget.postId, 3, widget.paths),
                  ),
                );
              })
                  : FlatButton(child: Image.file(File(widget.paths[3])), onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TakePictureScreen(firstCamera,
                        widget.postId, 3, widget.paths),
                  ),
                );
              })
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
          Container(
              child: widget.paths[4] == ''
                  ? FlatButton(child: Image(image: AssetImage(
                  'assets/tapForPicture.jpg'
              )), onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TakePictureScreen(firstCamera,
                        widget.postId, 4, widget.paths),
                  ),
                );
              })
                  : FlatButton(child: Image.file(File(widget.paths[4])), onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TakePictureScreen(firstCamera,
                        widget.postId, 4, widget.paths),
                  ),
                );
              })
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
          Container(
              child: widget.paths[5] == ''
                  ? FlatButton(child: Image(image: AssetImage(
                  'assets/tapForPicture.jpg'
              )), onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TakePictureScreen(firstCamera,
                        widget.postId, 5, widget.paths),
                  ),
                );
              })
                  : FlatButton(child: Image.file(File(widget.paths[5])), onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TakePictureScreen(firstCamera,
                        widget.postId, 5, widget.paths),
                  ),
                );
              })
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
          Container(
              child: widget.paths[6] == ''
                  ? FlatButton(child: Image(image: AssetImage(
                  'assets/tapForPicture.jpg'
              )), onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TakePictureScreen(firstCamera,
                        widget.postId, 6, widget.paths),
                  ),
                );
              })
                  : FlatButton(child: Image.file(File(widget.paths[6])), onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TakePictureScreen(firstCamera,
                        widget.postId, 6, widget.paths),
                  ),
                );
              })
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
          Container(
              child: widget.paths[7] == ''
                  ? FlatButton(child: Image(image: AssetImage(
                  'assets/tapForPicture.jpg'
              )), onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TakePictureScreen(firstCamera,
                        widget.postId, 7, widget.paths),
                  ),
                );
              })
                  : FlatButton(child: Image.file(File(widget.paths[7])), onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TakePictureScreen(firstCamera,
                        widget.postId, 7, widget.paths),
                  ),
                );
              })
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
          Container(
              child: widget.paths[8] == ''
                  ? FlatButton(child: Image(image: AssetImage(
                  'assets/tapForPicture.jpg'
              )), onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TakePictureScreen(firstCamera,
                        widget.postId, 8, widget.paths),
                  ),
                );
              })
                  : FlatButton(child: Image.file(File(widget.paths[8])), onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TakePictureScreen(firstCamera,
                        widget.postId, 8, widget.paths),
                  ),
                );
              })
          ),
        ],
      ),
    );
  }

}