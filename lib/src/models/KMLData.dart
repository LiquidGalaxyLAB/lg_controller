class KMLData {
  String title = "";
  String desc = "";
  double latitude = 0, longitude = 0, bearing = 0, zoom = 0, tilt = 0;
  int count = 0;

  KMLData(
      {this.title,
      this.desc,
      this.latitude,
      this.longitude,
      this.bearing,
      this.zoom,
      this.tilt});

  getTitle() {
    return title;
  }

  getDesc() {
    return desc;
  }

  getLat() {
    return latitude;
  }

  getLgt() {
    return longitude;
  }

  getBearing() {
    return bearing;
  }

  getZoom() {
    return zoom;
  }

  getTilt() {
    return tilt;
  }

  KMLData.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        desc = json['desc'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        bearing = json['bearing'],
        zoom = json['zoom'],
        tilt = json['tilt'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'desc': desc,
        'latitude': latitude,
        'longitude': longitude,
        'bearing': bearing,
        'zoom': zoom,
        'tilt': tilt,
      };

  Map<String, dynamic> toDatabaseMap() => {
        'title': title,
        'desc': desc,
        'latitude': latitude,
        'longitude': longitude,
        'bearing': bearing,
        'zoom': zoom,
        'tilt': tilt,
        'count': 0,
      };

  KMLData.fromDatabaseMap(Map<String, dynamic> json)
      : title = json['title'],
        desc = json['desc'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        bearing = json['bearing'],
        zoom = json['zoom'],
        tilt = json['tilt'],
        count = json['count'];
}
