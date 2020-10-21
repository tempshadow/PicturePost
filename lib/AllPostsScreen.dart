import 'package:Picturepost/PostData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'PostScreen.dart';
import 'main.dart';
import 'package:geolocator/geolocator.dart';

// ignore: must_be_immutable
class AllPostsScreen extends StatefulWidget{
  LocationData currentLocation;
  List<PostData> data;
  AllPostsScreen(List<PostData> data, LocationData currentLocation) {
    this.data = data;
    this.currentLocation = currentLocation;
  }
  @override
  _State createState() => _State();
}

class PostDistance {
  PostData post;
  double distance;
  PostDistance(PostData post, double distance) {
    this.post = post;
    this.distance = distance;
  }
}

class _State extends State<AllPostsScreen> {
  List<PostData> list = [];
  List<bool> isSelected = [true, false];
  bool distanceButtonClicked = true;
  bool alphabeticButtonClicked = false;

  List<PostDistance> listSort() {
    List<PostDistance> distances = [];
    list = widget.data;
    for(var post in list) {
      double distanceInMeters =
      GeolocatorPlatform.instance.distanceBetween(
        widget.currentLocation.latitude,
        widget.currentLocation.longitude,
        post.lat,
        post.lon,
      );
      double miles = distanceInMeters * 0.000621371192;
      distances.add(new PostDistance(post, miles));
    }
    if(distanceButtonClicked == true) {
      distances.sort((a, b) => a.distance.compareTo(b.distance));
    }
    if(alphabeticButtonClicked == true) {
      distances.sort((a, b) => a.post.name.compareTo(b.post.name));
    }
    return distances;
  }

  Widget listView() {
    var posts = listSort();
    return ListView.builder(itemBuilder: (BuildContext context, int index) {
      var post = posts[index];
      return ListTile(
        title: Center(
          child: Text(post.post.name
          ),
        ),
        subtitle: Text(double.parse(
            (post.distance).toStringAsFixed(2)).toString()),
        trailing: Icon(
            Icons.keyboard_arrow_right
        ),
        onTap: ()  {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => new PostScreen(post.post.name,
                  widget.data.indexOf(post.post).toString(),
                  post.post.lat, post.post.lon, widget.data,
                  post.post.installDate,
                  post.post.postId, post.post.postPictureId,
                  post.post.referencePictureSetId, 3,
                  widget.currentLocation),
            ),
          );
        },
      );
    },
      itemCount: list.length,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.green,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MyApp(posts: widget.data),
              ),
            );
          },
        ),
        title: Text("All Posts", style: TextStyle(color: Colors.black)
        ),
      ),
      body:
        Column(
          children: <Widget>[
            Container(
              child: Align(
                alignment: Alignment.center,
                child: ToggleButtons(
                  children: <Widget>[
                    Text("Distance", style: TextStyle(color: Colors.green),),
                    Text("Name", style: TextStyle(color: Colors.green),)
                  ],
                  onPressed: (int index){
                    if(index == 0) {
                      setState(() {
                        distanceButtonClicked = true;
                        alphabeticButtonClicked = false;
                        listView();
                      });
                    }
                    else {
                      setState(() {
                        distanceButtonClicked = false;
                        alphabeticButtonClicked = true;
                        listView();
                      });
                    }
                    setState(() {
                      for (int buttonIndex = 0; buttonIndex < isSelected.length;
                      buttonIndex++) {
                        if (buttonIndex == index) {
                          isSelected[buttonIndex] = true;
                        } else {
                          isSelected[buttonIndex] = false;
                        }
                      }
                    });
                  },
                  isSelected: isSelected,
                ),
              ),
            ),
            Expanded(
              child:
              listView()
            ),
          ],
        ),
    );
  }

}