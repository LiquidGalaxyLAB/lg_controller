class SegregatedKmlData {
  String data;
  String category;

  SegregatedKmlData.fromJson(Map<String, dynamic> json)
      : data = json['data'],
        category = json['category'];
}
