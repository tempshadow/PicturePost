import 'package:Picturepost/FavDB.dart';
import 'package:Picturepost/Favorite.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'LoadingPage.dart';
import 'PostData.dart';
import 'MapMarker.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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

class MyAppState extends State<MyApp> {
  FavDB favDatabase = new FavDB();
  GoogleMapController mapController;
  final List<Marker> markers = [];
  List<PostData> posts;
  List<Favorite> favorites;
  final LatLng _center = const LatLng(39.8283, -98.5795);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void fillList(BuildContext context) {
    for (var post in posts) {
      markers.add(MapMarker(id: posts.indexOf(post).toString(), position:
        LatLng(post.lat, post.lon), icon: BitmapDescriptor.fromAsset(
          "assets/default.png"),name: post.name,
          description: post.description, context: context).toMarker());
    }
  }
  LocationData currentLocation;
  LocationData destinationLocation;
  Location location;
  @override
  Widget build(BuildContext context) {
    favDatabase.create();
    posts = widget.posts;
    fillList(context);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Log In", style: TextStyle(
              color: Colors.green)
          ),
            backgroundColor: Colors.white,
            actions: <Widget>[
              OutlineButton(
                  child: Text("All Posts", style: TextStyle(color: Colors.green)),
                  onPressed: null,
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0))
              ),
              OutlineButton(
                  child: Text("Favorites", style: TextStyle(color: Colors.green)),
                  onPressed: null,
                  shape: RoundedRectangleBorder(borderRadius:
                  new BorderRadius.circular(10.0)),
              ),
              IconButton(
                icon: Icon(Icons.my_location, color: Colors.green),
                onPressed: updateMap,
              )
            ]
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 3.25,
          ),
          markers: markers.toSet(),
        ),
      ),
    );
  }

  void getFavorites() async{
    favorites = await favDatabase.favorites();
  }

  void updateMap() async {

    // create a new CameraPosition instance
    // every time the location changes, so the camera
    // follows the pin as it moves with an animation
    location = new Location();
    currentLocation = await location.getLocation();
    CameraPosition cPosition = CameraPosition(
    target: LatLng(currentLocation.latitude,
    currentLocation.longitude),
      zoom: 17.0,
    );
    final GoogleMapController controller = mapController;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));   // do this inside the setState() so Flutter gets notified
    // that a widget update is due
    setState(() {      // updated position
    //var pinPosition = LatLng(currentLocation.latitude,
    //currentLocation.longitude);

    // the trick is to remove the marker (by id)
    // and add it again at the updated location
    //_markers.removeWhere(
    //(m) => m.markerId.value == ‘sourcePin’);      _markers.add(Marker(
    //markerId: MarkerId(‘sourcePin’),
    //position: pinPosition, // updated position
    //icon: sourceIcon
    //));
    });
  }
}
