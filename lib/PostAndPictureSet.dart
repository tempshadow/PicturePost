class PostAndPictureSet {
  String name;
  double lon;
  int postId;
  List<dynamic> pictureSets = [];
  double lat;

  PostAndPictureSet(
    this.name, this.lon, this.postId, this.pictureSets, this.lat
);

  PostAndPictureSet.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    lon = json['lon'].toDouble();
    postId = json['postId'];
    List<dynamic> sets = json['pictureSets'];
    for(var set in sets) {
      pictureSets.add(set);
    }
    lat = json['lat'].toDouble();
  }
}