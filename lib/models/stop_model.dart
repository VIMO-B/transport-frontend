class StopModel {
  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final int order;

  StopModel({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.order,
  });

  factory StopModel.fromJson(Map<String, dynamic> json) {
    return StopModel(
      id: json['id'],
      name: json['name'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      order: json['order'],
    );
  }
}