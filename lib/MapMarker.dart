import 'package:Picturepost/PostData.dart';
import 'package:Picturepost/PostScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:location/location.dart';
class MapMarker {
  final String id;
  final int postId;
  final int setId;
  final int pictureId;
  final String date;
  final LatLng position;
  final BitmapDescriptor icon;
  final String name;
  final String description;
  final BuildContext context;
  final int screen;
  final LocationData currentLocation;
  List<PostData> data;
  MapMarker({
    @required this.id,
    @required this.position,
    @required this.icon,
    @required this.name,
    @required this.description,
    @required this.context,
    @required this.data,
    @required this.date,
    @required this.postId,
    @required this.pictureId,
    @required this.setId,
    @required this.screen,
    @required this.currentLocation,

  });

  Marker toMarker() => Marker(
    markerId: MarkerId(id),
    position: LatLng(
      position.latitude,
      position.longitude,
    ),
    icon: icon,
    infoWindow:  InfoWindow(
      title: name,
      snippet: description,
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => new PostScreen(name, id,
                position.latitude, position.longitude, data, date, postId,
                pictureId, setId, screen, currentLocation),
          ),
        );
      }
    ),
  );
}