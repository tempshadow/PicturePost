import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
class MapMarker {
  final String id;
  final LatLng position;
  final BitmapDescriptor icon;
  final String name;
  final String description;
  MapMarker({
    @required this.id,
    @required this.position,
    @required this.icon,
    @required this.name,
    @required this.description,
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
    ),
  );
}