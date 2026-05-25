import 'dart:async';

class BusLocationService {
  // Coordenada base solicitada
  double _lat = 7.037544;
  double _lng = -73.072619;

  final _controller = StreamController<Map<String, double>>.broadcast();

  Stream<Map<String, double>> get stream => _controller.stream;

  BusLocationService() {
    _startSimulation();
  }

  void _startSimulation() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      // Simulación mínima de movimiento (ajustable)
      _lat += 0.00005;
      _lng += 0.00003;

      _controller.add({
        "lat": _lat,
        "lng": _lng,
      });
    });
  }

  void dispose() {
    _controller.close();
  }
}