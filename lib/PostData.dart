class PostData {
  final String installDate;
  final int postPictureId;
  final int referencePictureSetId;
  final bool ready;
  final String name;
  final String description;
  final int personId;
  final double lon;
  final int postId;
  final String recordTimeStamp;
  final double lat;

  PostData({this.installDate, this.postPictureId, this.referencePictureSetId,
    this.ready, this.name, this.description, this.personId, this.lon,
    this.postId, this.recordTimeStamp, this.lat});

  factory PostData.fromJson(Map<String, dynamic> json) {
    return PostData(
      installDate: json['installDate'],
      postPictureId: json['postPictureId'],
      referencePictureSetId: json['referencePictureSetId'],
      ready: json['ready'],
      name: json['name'],
      description: json['description'],
      personId: json['personId'],
      lon: json['lon'].toDouble(),
      postId: json['postId'],
      recordTimeStamp: json['recordTimeStamp'],
      lat: json['lat'].toDouble(),
    );
  }
}