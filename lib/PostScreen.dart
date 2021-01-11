import 'dart:convert';

import 'package:Picturepost/AllPostsScreen.dart';
import 'package:Picturepost/CardinalPicturesScreen.dart';
import 'package:Picturepost/FavDB.dart';
import 'package:Picturepost/FavoriteListScreen.dart';
import 'package:Picturepost/PictureSetScreen.dart';
import 'package:Picturepost/PostAndPictureSet.dart';
import 'package:Picturepost/PostData.dart';
import 'package:intl/intl.dart';
import 'package:Picturepost/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Favorite.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

import 'PictureSet.dart';

Future<PostAndPictureSet> fetchPostAndPictures(
http.Client client, int postId) async {
  final response =
      await client.get(
          "https://picturepost.ou.edu/app/GetPostAndPictureSets?postId=" +
      postId.toString());
  final testJSON = json.decode(response.body);
  PostAndPictureSet postAndPictures;
  postAndPictures = PostAndPictureSet.fromJson(testJSON);
  return postAndPictures;
}


Future<int> fetchPostInfo(http.Client client, int postId) async {
  final response =
  await client.get('https://picturepost.ou.edu/app/GetPost?postId=' +
      postId.toString());

  var parse = json.decode(response.body);
  int referencePictureSetId = parse[0]['referencePictureSetId'];

  // Use the compute function to run parsePhotos in a separate isolate.
  return referencePictureSetId;
}


// ignore: must_be_immutable
class PostScreen extends StatefulWidget {
  String name;
  Favorite favorite;
  FavDB db;
  int postId;
  int screen;
  String id;
  List<Favorite> list;
  List<PostData> data;
  LocationData currentLocation;
  double lat;
  double lon;
  int pictureId;
  int setId;
  String date;
  PostScreen(String name, String id, double lat, double lon,
      List<PostData> data, String date, int postId, int pictureId, int setID,
  int screen, LocationData currentLocation) {
    this.name = name;
    this.data = data;
    this.postId = postId;
    this.id = id;
    this.favorite = new Favorite(id: int.parse(id), lat: lat, lon: lon);
    this.screen = screen;
    this.currentLocation = currentLocation;
    this.lon = lon;
    this.lat =lat;
    this.setId = setID;
    this.pictureId = pictureId;
    this.date = date;

  }

  @override
  _State createState() => _State();
}


class _State extends State<PostScreen> {
  int pictureId;
  PostAndPictureSet postAndPictures;
  List<PictureSet> pictureSet = [];
  FavDB db;
  List<Favorite> favorites = [];
  bool isSwitched = false;
  static const oneSecond = Duration(milliseconds: 5);

  @override
  void initState() {
    begin();
    super.initState();
  }
  void begin() async {
    db = await Future.delayed(oneSecond, () => FavDB());
    db.create();
    favorites = await Future.delayed(Duration(milliseconds: 5),
            () => db.favorites());
    postAndPictures = await fetchPostAndPictures(http.Client(),
        widget.postId);
    for(var data in postAndPictures.pictureSets) {
      int pictureSetId = data['pictureSetId'];
      String pictureSetTimestamp = data['pictureSetTimeStamp'];
      var pictureIds = data['pictureIds'];
      pictureSet.add(new PictureSet(pictureSetId, pictureSetTimestamp,
          pictureIds));
    }
    int referencePictureSetId = await fetchPostInfo(http.Client(),
        widget.postId);

    for(var sets in pictureSet) {
      if(sets.pictureSetId == referencePictureSetId) {
        for(var pic in sets.pictureIds) {
          if(pic != 0) {
            pictureId = await Future.delayed(oneSecond, () => pic);
            break;
          }
        }
      }
    }
    getSwitchValues();
  }


  getSwitchValues() async {
    isSwitched = await Future.delayed(Duration(milliseconds: 5),
            () => getSwitchState());
    if(mounted) {
      setState(() {});
    }
  }
  onchange(bool value) {
    if(mounted) {
      setState(() {
        isSwitched=value;
        if(value == true) {
          db.insert(widget.favorite);
        }
        else {
          db.delete(widget.favorite.id);
        }
      });
    }
  }

  Future<bool> getSwitchState() async {
    if(favorites.length > 0) {
      for(var favorite in favorites) {
        if(widget.favorite.id == favorite.id) {
          isSwitched = true;
          break;
        }
        else {
          isSwitched = false;
        }
      }
    }
    else {
      isSwitched = false;
    }

    return isSwitched;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: BackButton(
            color: Colors.green,
            onPressed: () {
              switch(widget.screen) {
                case 1: {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyApp(posts: widget.data),
                    ),
                  );
                }
                break;

                case 2: {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllPostsScreen(
                          widget.data, widget.currentLocation),
                    ),
                  );
                }
                break;

                case 3: {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavoriteListScreen(
                          widget.data, widget.currentLocation),
                    ),
                  );
                }
                break;
              }
            },
          ),
          title: Text(widget.name, style: TextStyle(color: Colors.black)
          ),
        ),
        body:
            Column(
              children: <Widget>[
                Image.network("https://picturepost.ou.edu/app/GetPicture?pictureId=" +
                pictureId.toString(), height: 150, width: double.infinity,
                    fit:BoxFit.fill),

                Center(
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text('Favorite Post'),
                      Switch(
                        value: isSwitched,
                        onChanged: (bool value)=>onchange(value),
                        activeTrackColor: Colors.lightGreenAccent,
                        activeColor: Colors.green,
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Color.fromRGBO(255, 230, 230, 1.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Taken Picture Sets"),
                  ),
                ),
                Center(
                  child: FlatButton(
                    textColor: Colors.green,
                    onPressed: () {
                      List<String> list = ['', '', '', '', '', '', '', '', ''];
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            PictureSetScreen(widget.name, widget.pictureId,
                                widget.screen, widget.id, widget.lon,
                                widget.lat, widget.date, widget.setId,
                                widget.data, widget.currentLocation,
                                widget.postId, list, 0)
                        ),
                      );
                    },
                    child: Text("Take New Picture Set"),
                  ),
                ),
                Container(
                  color: Color.fromRGBO(255, 230, 230, 1.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Picture Sets"),
                  ),
                ),
                Expanded(
                  child:
                  ListView.builder(

                    itemBuilder: (BuildContext context, int index) {
                      var sets = pictureSet[index];

                      return ListTile(
                        title: Center(
                          child: Text(DateFormat.yMd().add_jm().format(
                              DateTime.parse(sets.pictureSetTimeStamp))
                          ),
                        ),
                        trailing: Icon(
                          Icons.keyboard_arrow_right
                        ),
                        onTap: ()  {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                CardinalPicturesScreen(
                                    sets.pictureIds,
                                    sets.pictureSetTimeStamp
                                )
                            ),
                          );
                        },
                      );
                    },
                    itemCount: pictureSet.length,
                  ),
                ),
              ],
            )
    );
  }
}