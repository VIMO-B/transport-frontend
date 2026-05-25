import 'package:flutter/material.dart';
import '../models/stop_model.dart';

class RouteSelectedState {
  static final ValueNotifier<List<StopModel>> stopsNotifier =
      ValueNotifier([]);

  static void setStops(List<StopModel> stops) {
    stopsNotifier.value = stops;
  }

  static List<StopModel> getStops() {
    return stopsNotifier.value;
  }

  static void clear() {
    stopsNotifier.value = [];
  }
}