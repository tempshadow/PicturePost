import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  LocationData currentLocation;
  LocationData destinationLocation;
  Location location;
  @override
  Widget build(BuildContext context) {
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
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0))
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
            zoom: 11.0,
          ),
        ),
      ),
    );
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
