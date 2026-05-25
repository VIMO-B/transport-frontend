import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../core/config/app_config.dart';
import '../../models/stop_model.dart';

class RouteStopsService {

  static Future<List<StopModel>> getStopsByRoute(int routeId) async {
    final url = Uri.parse(
      "${AppConfig.baseUrl}/routes/$routeId/stops",
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception("Error cargando stops");
    }

    final decoded = jsonDecode(response.body);

    final List stops = decoded['stops'];

    return stops.map((e) => StopModel.fromJson(e)).toList();
  }
}