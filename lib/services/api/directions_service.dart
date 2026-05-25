import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class DirectionsService {

  static const String _apiKey = "TU_API_KEY";

  static Future<List<PointLatLng>> getRoute(
    double originLat,
    double originLng,
    double destLat,
    double destLng,
  ) async {

    final url =
        "https://maps.googleapis.com/maps/api/directions/json"
        "?origin=$originLat,$originLng"
        "&destination=$destLat,$destLng"
        "&mode=driving"
        "&key=$_apiKey";

    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);

    print("DIRECTIONS STATUS: ${data["status"]}");
    print("DIRECTIONS RESPONSE: $data");

    // 🔴 VALIDACIÓN CLAVE
    if (data["status"] != "OK") {
      print("❌ ERROR: ${data["status"]}");
      return [];
    }

    final routes = data["routes"];

    if (routes == null || routes.isEmpty) {
      print("❌ NO ROUTES");
      return [];
    }

    final encoded = routes[0]["overview_polyline"]?["points"];

    if (encoded == null) {
      print("❌ NO POLYLINE");
      return [];
    }

    return PolylinePoints().decodePolyline(encoded);
  }
}