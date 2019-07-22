/// Model to serialize/de-serialize Google Drive description.
class SegregatedKmlData {
  String data;
  String category;

  /// Create [SegregatedKmlData] instance from JSON map.
  SegregatedKmlData.fromJson(Map<String, dynamic> json)
      : data = json['data'],
        category = json['category'];

  /// Convert [SegregatedKmlData] instance to JSON map.
  Map<String, dynamic> toJson() => {
        'data': data,
        'category': category,
      };

  SegregatedKmlData();
}
