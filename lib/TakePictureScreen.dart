import 'dart:async';
import 'dart:io';
import 'package:Picturepost/PictureSetScreen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:location/location.dart';
import 'PostData.dart';
import 'package:native_device_orientation/native_device_orientation.dart';

// ignore: must_be_immutable
class TakePictureScreen extends StatefulWidget {
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
  CameraDescription camera;
  int index;
  TakePictureScreen(this.camera, this.postId, this.index, this.paths, this.name,
      this.screen, this.id, this.data, this.currentLocation, this.setID,
      this.date, this.lat, this.lon, this.pictureId);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Take a picture')),
      // Wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner
      // until the controller has finished initializing.
      body: NativeDeviceOrientationReader(
          builder: (context) {
            NativeDeviceOrientation orientation =
            NativeDeviceOrientationReader.orientation(context);

            int turns;
            switch (orientation) {
              case NativeDeviceOrientation.landscapeLeft: turns = -1; break;
              case NativeDeviceOrientation.landscapeRight: turns = 1; break;
              case NativeDeviceOrientation.portraitDown: turns = 2; break;
              default: turns = 0; break;
            }

            return RotatedBox(
                quarterTurns: turns,
                child: FutureBuilder<void>(
                  future: _initializeControllerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {

                      // If the Future is complete, display the preview.
                      return CameraPreview(_controller);
                    } else {
                      // Otherwise, display a loading indicator.
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                )
            );
          }
      ),/*FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {

            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
      )*/
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Construct the path where the image should be saved using the
            // pattern package.
            final path = join(
              // Store the picture in the temp directory.
              // Find the temp directory using the `path_provider` plugin.
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            );

            // Attempt to take a picture and log where it's been saved.
            await _controller.takePicture(path);
            Orientation currentOrientation = MediaQuery.of(context).orientation;
            if(currentOrientation == Orientation.landscape){
              widget.paths[widget.index] = path;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => PictureSetScreen(widget.name,
                      widget.pictureId, widget.screen, widget.id, widget.lon,
                      widget.lat, widget.date, widget.setID, widget.data,
                      widget.currentLocation, widget.postId, widget.paths,
                      widget.index+1),
                ),
              );
            }
            else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: new Text("Pictures must be taken horizontally"),
                    actions: <Widget>[
                      new FlatButton(
                          onPressed: () {Navigator.of(context).pop();},
                          child: new Text("Close"))
                    ],
                  );
                }
              );
            }
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
      ),
    );
  }
}