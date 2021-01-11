
class Favorite {
  final int id;
  final double lat;
  final double lon;
  final int personId;

  Favorite({this.id, this.lat, this.lon,this.personId});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'lat': lat,
      'lon': lon,
      'personId': personId
    };
  }
}