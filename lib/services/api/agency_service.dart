import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../core/config/app_config.dart';
import '../../models/agency_model.dart';

class AgencyService {
  static Future<List<Agency>> getAgencies() async {
    final url = Uri.parse(AppConfig.companyEndpoint);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      return data.map((e) => Agency.fromJson(e)).toList();
    } else {
      throw Exception("Error cargando agencias");
    }
  }
}