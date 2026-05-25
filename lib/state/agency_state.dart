import '../models/agency_model.dart';

class AgencyState {
  static Agency? _agency;

  static void setAgency(Agency agency) {
    _agency = agency;
  }

  static Agency? getAgency() {
    return _agency;
  }

  static int? getAgencyId() {
    return _agency?.id;
  }

  static String? getAgencyName() {
    return _agency?.name;
  }

  /// 🔥 ESTO ES LO QUE TE FALTABA
  static void clear() {
    _agency = null;
  }
}