import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../core/config/app_config.dart';
import '../../models/route_model.dart';

class RouteService {

  static Future<List<RouteModel>> getRoutesByCompany(int companyId) async {
    final url = Uri.parse(
      "${AppConfig.baseUrl}/routes?company_id=$companyId",
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    final decoded = jsonDecode(response.body);

    if (decoded is Map && decoded["items"] is List) {
      return (decoded["items"] as List)
          .map((e) => RouteModel.fromJson(e))
          .toList();
    }

    throw Exception("Formato inesperado: ${response.body}");
  }
}