import 'package:Picturepost/PostData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'FavDB.dart';
import 'Favorite.dart';
import 'PostScreen.dart';
import 'main.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';

// ignore: must_be_immutable
class FavoriteListScreen extends StatefulWidget {
  List<PostData> data;
  LocationData currentLocation;
  FavoriteListScreen(List<PostData> data, LocationData currentLocation) {
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

class _State extends State<FavoriteListScreen>  {
  List<bool> isSelected = [true, false];
  List<PostData> list = [];
  FavDB db;
  List<Favorite> favorites = [];
  static const oneSecond = Duration(milliseconds: 5);
  bool loading = true;
  bool editing = false;
  bool distanceButtonClicked = true;
  bool alphabeticButtonClicked = false;

  List<PostDistance> listSort() {
    List<PostDistance> distances = [];
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

  void begin() async  {
    db = await Future.delayed(oneSecond, () => FavDB());
    db.create();
    favorites = await Future.delayed(Duration(milliseconds: 5),
            () => db.favorites());
    fillList();
    if(mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  void fillList() {
    if (favorites.length > 0) {
      for (var favorite in favorites) {
        for (var post in widget.data) {
          if (widget.data.indexOf(post) == favorite.id) {
            list.add(post);
          }
        }
      }
    }
  }

  Widget listView() {
    var posts = listSort();
    if(editing == true) {
      return ListView.builder(itemBuilder: (BuildContext context, int index) {
        final post = posts[index];
        return Dismissible(
          direction: DismissDirection.horizontal,
          key: new ObjectKey(post),
          onDismissed: (direction) {
            int id;
            PostData tempPost;
            for(var favorite in favorites){
              for(var temp in widget.data) {
                if(favorite.id == widget.data.indexOf(temp)) {
                  if(temp.postId == post.post.postId) {
                    id = favorite.id;
                    tempPost = temp;
                    break;
                  }
                }
              }
            }
            posts.removeAt(index);
            db.delete(id);
            list.removeAt(list.indexOf(tempPost));
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(post.post.name +
                "dismissed")
            ));
          },
          background: Container(color: Colors.red),
          child: ListTile(
            leading: Icon(Icons.remove_circle_outline, color: Colors.red,
            ),
            title: Center(
              child: Text(post.post.name
              ),
            ),
            subtitle: Text(double.parse(post.distance.toStringAsFixed(2)
            ).toString()),
          ),
        );
      },
        itemCount: list.length,);
    }
    else {
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

  }

  Widget buildFlatButton() {
    if (editing == true) {
      return new FlatButton(
          onPressed: () {
            setState(() {
              editing = false;
              listView();
            });
            },
          child: Text("Done")
      );
    }
    else {
      return new FlatButton(
          onPressed: () {
            setState(() {
              editing = true;
              listView();
            });
            },
          child: Text("Edit")
      );
    }
  }
  @override
  void initState() {
    begin();
    super.initState();
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
        title: Text("Favorite Posts", style: TextStyle(color: Colors.black)
        ),
        actions: <Widget>[
          buildFlatButton(),
        ],
      ),
      body: loading == true // If favorites is null
          ? Center(
        // Display Progress Indicator
        child: CircularProgressIndicator(),
      )
          :
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
              child: listView()
            ),
          ],
        ),
    );
  }

}