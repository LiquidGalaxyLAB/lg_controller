class KMLData {
  String title;
  String desc;

  KMLData(this.title, this.desc);

  getTitle() {
    return title;
  }

  getDesc() {
    return desc;
  }

  KMLData.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        desc = json['desc'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'desc': desc,
      };

  Map<String, dynamic> toDatabaseMap() => {
        'title': title,
        'desc': desc,
        'count': 0,
      };
}
