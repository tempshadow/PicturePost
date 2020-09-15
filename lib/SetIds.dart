class SetIds {
  List<int> ids = [];
  SetIds(this.ids);

  SetIds.fromJson(Map<String, dynamic> json) {
    List<dynamic> pictureSetIds = json["pictureSetIds"];
    for(var id in pictureSetIds) {
      ids.add(id);
    }
  }
}