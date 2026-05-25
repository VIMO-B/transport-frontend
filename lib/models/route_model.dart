class RouteModel {
  final int id;
  final String code;
  final String name;
  final String origin;
  final String destination;
  final bool isActive;

  RouteModel({
    required this.id,
    required this.code,
    required this.name,
    required this.origin,
    required this.destination,
    required this.isActive,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      id: json['id'],
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      origin: json['origin'] ?? '',
      destination: json['destination'] ?? '',
      isActive: json['is_active'] ?? true,
    );
  }
}