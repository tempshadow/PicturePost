import 'dart:io';
import 'package:Picturepost/TakePictureScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'PostData.dart';
import 'package:location/location.dart';
import 'PostScreen.dart';

// ignore: must_be_immutable
class PictureSetScreen extends StatefulWidget {
  String name;
  int postId;
  int screen;
  String id;
  List<PostData> data;
  LocationData currentLocation;
  List<String> paths;
  double lat;
  double lon;
  String date;
  int pictureId;
  int setID;
  int position;
  PictureSetScreen(this.name, this.pictureId, this.screen, this.id,
      this.lon,this.lat, this.date, this.setID, this.data, this.currentLocation,
      this.postId, this.paths, this.position);

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
    if(widget.position > 0 && widget.position <= 8) {
      if(widget.paths[widget.position] == '' ) {
        _showDialog(widget.position);
      }
    }
  }

  void _showDialog(int index) {
    // flutter defined function
    List<String> directions = ["","Take North East Picture", "Take East Picture",
    "Take South East Picture", "Take South Picture", "Take South West Picture",
    "Take West Picture", "Take North West Picture", "Take Up Picture"];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: new Text(directions[index]),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Don't Take"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TakePictureScreen(firstCamera,
                          widget.postId, widget.position, widget.paths,
                          widget.name, widget.screen, widget.id, widget.data,
                          widget.currentLocation, widget.setID, widget.date,
                          widget.lat, widget.lon, widget.pictureId),
                    ),
                  );
                },
                child: new Text("Take"))
          ],
        );
      },
    );
  }

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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PostScreen(widget.name, widget.id,
                    widget.lat, widget.lon, widget.data, widget.date,
                    widget.postId, widget.pictureId, widget.setID, widget.screen,
                    widget.currentLocation),
              ),
            );
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
                        widget.postId, 0, widget.paths,
                        widget.name, widget.screen, widget.id, widget.data,
                        widget.currentLocation, widget.setID, widget.date,
                        widget.lat, widget.lon, widget.pictureId),
                  ),
                );
              })
                  : FlatButton(child: Image.file(File(widget.paths[0])), onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TakePictureScreen(firstCamera,
                        widget.postId, 0, widget.paths,
                        widget.name, widget.screen, widget.id, widget.data,
                        widget.currentLocation, widget.setID, widget.date,
                        widget.lat, widget.lon, widget.pictureId),
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
                        widget.postId, 1, widget.paths,
                        widget.name, widget.screen, widget.id, widget.data,
                        widget.currentLocation, widget.setID, widget.date,
                        widget.lat, widget.lon, widget.pictureId),
                  ),
                );
              })
                  : FlatButton(child: Image.file(File(widget.paths[1])), onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TakePictureScreen(firstCamera,
                        widget.postId, 1, widget.paths,
                        widget.name, widget.screen, widget.id, widget.data,
                        widget.currentLocation, widget.setID, widget.date,
                        widget.lat, widget.lon, widget.pictureId),
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
                        widget.postId, 2, widget.paths,
                        widget.name, widget.screen, widget.id, widget.data,
                        widget.currentLocation, widget.setID, widget.date,
                        widget.lat, widget.lon, widget.pictureId),
                  ),
                );
              })
                  : FlatButton(child: Image.file(File(widget.paths[2])), onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TakePictureScreen(firstCamera,
                        widget.postId, 2, widget.paths,
                        widget.name, widget.screen, widget.id, widget.data,
                        widget.currentLocation, widget.setID, widget.date,
                        widget.lat, widget.lon, widget.pictureId),
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
                        widget.postId, 3, widget.paths,
                        widget.name, widget.screen, widget.id, widget.data,
                        widget.currentLocation, widget.setID, widget.date,
                        widget.lat, widget.lon, widget.pictureId),
                  ),
                );
              })
                  : FlatButton(child: Image.file(File(widget.paths[3])), onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TakePictureScreen(firstCamera,
                        widget.postId, 3, widget.paths,
                        widget.name, widget.screen, widget.id, widget.data,
                        widget.currentLocation, widget.setID, widget.date,
                        widget.lat, widget.lon, widget.pictureId),
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
                        widget.postId, 4, widget.paths,
                        widget.name, widget.screen, widget.id, widget.data,
                        widget.currentLocation, widget.setID, widget.date,
                        widget.lat, widget.lon, widget.pictureId),
                  ),
                );
              })
                  : FlatButton(child: Image.file(File(widget.paths[4])), onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TakePictureScreen(firstCamera,
                        widget.postId, 4, widget.paths,
                        widget.name, widget.screen, widget.id, widget.data,
                        widget.currentLocation, widget.setID, widget.date,
                        widget.lat, widget.lon, widget.pictureId),
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
                        widget.postId, 5, widget.paths,
                        widget.name, widget.screen, widget.id, widget.data,
                        widget.currentLocation, widget.setID, widget.date,
                        widget.lat, widget.lon, widget.pictureId),
                  ),
                );
              })
                  : FlatButton(child: Image.file(File(widget.paths[5])), onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TakePictureScreen(firstCamera,
                        widget.postId, 5, widget.paths,
                        widget.name, widget.screen, widget.id, widget.data,
                        widget.currentLocation, widget.setID, widget.date,
                        widget.lat, widget.lon, widget.pictureId),
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
                        widget.postId, 6, widget.paths,
                        widget.name, widget.screen, widget.id, widget.data,
                        widget.currentLocation, widget.setID, widget.date,
                        widget.lat, widget.lon, widget.pictureId),
                  ),
                );
              })
                  : FlatButton(child: Image.file(File(widget.paths[6])), onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TakePictureScreen(firstCamera,
                        widget.postId, 6, widget.paths,
                        widget.name, widget.screen, widget.id, widget.data,
                        widget.currentLocation, widget.setID, widget.date,
                        widget.lat, widget.lon, widget.pictureId),
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
                        widget.postId, 7, widget.paths,
                        widget.name, widget.screen, widget.id, widget.data,
                        widget.currentLocation, widget.setID, widget.date,
                        widget.lat, widget.lon, widget.pictureId),
                  ),
                );
              })
                  : FlatButton(child: Image.file(File(widget.paths[7])), onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TakePictureScreen(firstCamera,
                        widget.postId, 7, widget.paths,
                        widget.name, widget.screen, widget.id, widget.data,
                        widget.currentLocation, widget.setID, widget.date,
                        widget.lat, widget.lon, widget.pictureId),
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
                        widget.postId, 8, widget.paths,
                        widget.name, widget.screen, widget.id, widget.data,
                        widget.currentLocation, widget.setID, widget.date,
                        widget.lat, widget.lon, widget.pictureId),
                  ),
                );
              })
                  : FlatButton(child: Image.file(File(widget.paths[8])), onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TakePictureScreen(firstCamera,
                        widget.postId, 8, widget.paths,
                        widget.name, widget.screen, widget.id, widget.data,
                        widget.currentLocation, widget.setID, widget.date,
                        widget.lat, widget.lon, widget.pictureId),
                  ),
                );
              })
          ),
        ],
      ),
    );
  }

}