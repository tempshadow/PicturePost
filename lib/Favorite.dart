
class Favorite {
  final int id;
  final double lat;
  final double lon;

  Favorite({this.id, this.lat, this.lon});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'lat': lat,
      'lon': lon,
    };
  }
}