import 'package:Picturepost/AllPostsScreen.dart';
import 'package:Picturepost/FavDB.dart';
import 'package:Picturepost/Favorite.dart';
import 'package:Picturepost/FavoriteListScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'PostData.dart';
import 'MapMarker.dart';
import 'main.dart';

class MyAppState extends State<MyApp> {
  FavDB db;
  bool editing = false;
  List<bool> isSelected = [true, false];
  List<Favorite> favorites = [];
  void init() async{
    db = await Future.delayed(Duration(seconds: 1), () => FavDB());
  }
  GoogleMapController mapController;
  final List<Marker> markers = [];
  List<PostData> posts;
  final LatLng _center = const LatLng(39.8283, -98.5795);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void favoritesOnly(BuildContext context) {
    List<Marker> favoriteMarkers = [];
    List<Marker> allMarkers = [];
    markers.clear();
    if(favorites.length > 0) {
      for(var favorite in favorites) {
        for(var post in posts) {
          if(posts.indexOf(post) == favorite.id) {
            favoriteMarkers.add(new MapMarker(
                id: posts.indexOf(post).toString(),
                position:
                LatLng(post.lat, post.lon),
                icon: BitmapDescriptor.fromAsset(
                    "assets/favorite.png"),
                name: post.name,
                description: post.description,
                context: context,
                data: posts,
                postId: post.postId,
                date: post.installDate,
                pictureId: post.postPictureId,
                setId: post.referencePictureSetId).toMarker());
          }
        }
      }
      for(var favorite in favoriteMarkers) {
        allMarkers.removeWhere((element) =>
        int.parse(element.markerId.value) ==
            int.parse(favorite.markerId.value));
      }
      for(var favorite in favoriteMarkers) {
        markers.add(favorite);
      }
    }
  }

  void fillList(BuildContext context) async {
    List<Marker> favoriteMarkers = [];
    List<Marker> allMarkers = [];
    markers.clear();
    if(favorites.length > 0) {
      for(var favorite in favorites) {
        for(var post in posts) {
          if(posts.indexOf(post) == favorite.id) {
            favoriteMarkers.add(new MapMarker(
                id: posts.indexOf(post).toString(),
                position:
                LatLng(post.lat, post.lon),
                icon: BitmapDescriptor.fromAsset(
                    "assets/favorite.png"),
                name: post.name,
                description: post.description,
                context: context,
                data: posts,
                postId: post.postId,
                date: post.installDate,
                pictureId: post.postPictureId,
                setId: post.referencePictureSetId, screen: 1,
                currentLocation: currentLocation).toMarker());
          }
        }
      }
      for(var post in posts) {
        allMarkers.add(new MapMarker(
            id: posts.indexOf(post).toString(),
            position:
            LatLng(post.lat, post.lon),
            icon: BitmapDescriptor.fromAsset(
                "assets/default.png"),
            name: post.name,
            description: post.description,
            context: context,
            data: posts,
            postId: post.postId,
            date: post.installDate,
            pictureId: post.postPictureId,
            setId: post.referencePictureSetId, screen: 1,
            currentLocation: currentLocation).toMarker());
      }
      for(var favorite in favoriteMarkers) {
        allMarkers.removeWhere((element) =>
        int.parse(element.markerId.value) ==
            int.parse(favorite.markerId.value));
      }
      for(var favorite in favoriteMarkers) {
        markers.add(favorite);
      }
      for(var marker in allMarkers) {
        markers.add(marker);
      }
    }
    else {
      for(var post in posts) {
        markers.add(new MapMarker(
            id: posts.indexOf(post).toString(),
            position:
            LatLng(post.lat, post.lon),
            icon: BitmapDescriptor.fromAsset(
                "assets/default.png"),
            name: post.name,
            description: post.description,
            context: context,
            data: posts,
            postId: post.postId,
            date: post.installDate,
            pictureId: post.postPictureId,
            setId: post.referencePictureSetId, screen: 1,
            currentLocation: currentLocation).toMarker());
      }
    }
  }
  LocationData currentLocation;
  LocationData destinationLocation;
  Location location;
  bool loading = true;
  bool _isButtonDisabled = true;
  @override
  Widget build(BuildContext context) {
    if(loading) {
      startUp();
    }
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text("Log In", style: TextStyle(
                color: Colors.green)
            ),
            backgroundColor: Colors.white,
            actions: <Widget>[
              Center(
                child: ToggleButtons(
                  children: <Widget>[
                    Text("All Posts", style: TextStyle(color: Colors.green),),
                    Text("Favorites", style: TextStyle(color: Colors.green),)
                  ],
                  onPressed: (int index) {
                    if(index == 0) {
                      fillList(context);
                    }
                    else {
                      favoritesOnly(context);
                    }
                    setState(() {
                      for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
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
              IconButton(
                icon: Icon(Icons.my_location, color: Colors.green),
                onPressed: updateMap,
              )
            ]
        ),
        body: loading == true // If favorites is null
            ? Center(
          // Display Progress Indicator
          child: CircularProgressIndicator(),
             )
            : GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(currentLocation.latitude,
                currentLocation.longitude),
            zoom: 3.25,
          ),
          markers: markers.toSet(),
        ),
        bottomNavigationBar: BottomAppBar(
            child: Container(
                height: 55,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      buildPostListButton(),
                      buildFavoriteListButton(),
                    ]
                ),
            ),
        ),
      ),
    );
  }
  Widget buildPostListButton() {
    return new FlatButton(
      color: _isButtonDisabled ? Colors.transparent : Colors.white,
      child: Text("All Posts List"),
      onPressed: _isButtonDisabled ? null : () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => new AllPostsScreen(posts,
                currentLocation),
          ),
        );
      },
    );
  }

  Widget buildFavoriteListButton() {
    return new FlatButton(
      color: _isButtonDisabled ? Colors.transparent : Colors.white,
      child: Text("Favorites List"),
      onPressed: _isButtonDisabled ? null : () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
            new FavoriteListScreen(posts, currentLocation),
          ),
        );
      },
    );
  }

  void startUp() async {
    await init();
    await db.create();
    favorites = await db.favorites();
    posts = widget.posts;
    fillList(context);
    location = new Location();
    currentLocation = await location.getLocation();
    if(mounted) {
      setState(() {
        loading = false;
        _isButtonDisabled = false;
      });
    }
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
    //setState(() {      // updated position
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
    //});
  }
}
