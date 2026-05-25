class AppConfig {
  AppConfig._();

  static const String host = "10.152.164.60";
  static const String port = "8000";

  static const String baseUrl = "http://$host:$port/api/v1";

  static String get companyEndpoint => "$baseUrl/company";
}