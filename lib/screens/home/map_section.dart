import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import '../../state/route_selected_state.dart';
import '../../models/stop_model.dart';
import 'bus_bottom_sheet.dart';

class MapSection extends StatefulWidget {
  const MapSection({super.key});

  @override
  State<MapSection> createState() => _MapSectionState();
}

class _MapSectionState extends State<MapSection> {
  GoogleMapController? _mapController;

  LatLng _initialPosition = const LatLng(7.1193, -73.1227);
  bool _loading = true;

  Set<Polyline> polylines = {};
  List<StopModel> _lastStops = [];

  final String _apiKey = "AIzaSyDJoLRVvxZqlbTQy0z8GmdYst234WGTwRc";

  // =========================
  // 🚍 BUS STATE
  // =========================
  Timer? _busTimer;

  List<LatLng> _busRoutePoints = [];
  int _busIndex = 0;

  LatLng _busPosition = const LatLng(7.037544, -73.072619);

  Set<Marker> _busMarkers = {};

  // modal state
  bool _sheetOpen = false;

  // 👇 NUEVO ESTADO (CONTROL DE CARD ACTIVA)
  bool _busSelected = false;

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  @override
  void dispose() {
    _busTimer?.cancel();
    super.dispose();
  }

  Future<void> _initLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      setState(() => _loading = false);
      return;
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    if (!mounted) return;

    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
      _loading = false;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  // =========================
  // 🚍 MODAL ORIGINAL
  // =========================
  void _openBusSheet() {
    if (_sheetOpen) return;

    _sheetOpen = true;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return DraggableScrollableSheet(
          initialChildSize: 0.38,
          minChildSize: 0.10,
          maxChildSize: 0.75,
          builder: (context, scrollController) {
            return BusBottomSheet(
              isActive: _busSelected,
            );
          },
        );
      },
    ).whenComplete(() {
      _sheetOpen = false;

      // 👇 al cerrar el modal se desactiva la card
      setState(() {
        _busSelected = false;
      });
    });
  }

  // =========================
  // 🚍 BUS SIMULATION
  // =========================
  void _startBusSimulation() {
    _busTimer?.cancel();

    _busTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_busRoutePoints.isEmpty) return;
      if (_busIndex >= _busRoutePoints.length) return;

      setState(() {
        _busPosition = _busRoutePoints[_busIndex];

        _busMarkers = {
          Marker(
            markerId: const MarkerId("bus"),
            position: _busPosition,
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueBlue,
            ),
            infoWindow: const InfoWindow(title: "Bus en ruta"),

            // 👇 AQUÍ SE ACTIVA TODO
            onTap: () {
              setState(() {
                _busSelected = true;
              });

              _openBusSheet();
            },
          ),
        };

        _busIndex++;
      });
    });
  }

  // =========================
  // 🔥 ROUTE
  // =========================
  Future<List<LatLng>> _getRoute({
    required StopModel origin,
    required StopModel destination,
    List<StopModel> waypoints = const [],
  }) async {
    final uri = Uri.parse(
      "https://maps.googleapis.com/maps/api/directions/json"
      "?origin=${origin.latitude},${origin.longitude}"
      "&destination=${destination.latitude},${destination.longitude}"
      "&mode=driving"
      "&waypoints=${waypoints.map((e) => "${e.latitude},${e.longitude}").join("|")}"
      "&key=$_apiKey",
    );

    final response = await http.get(uri);
    final data = jsonDecode(response.body);

    if (data["status"] != "OK") return [];

    final encoded = data["routes"][0]["overview_polyline"]["points"];
    final decoded = PolylinePoints().decodePolyline(encoded);

    return decoded.map((e) => LatLng(e.latitude, e.longitude)).toList();
  }

  // =========================
  // 🔥 BUILD ROUTE
  // =========================
  Future<void> _buildRoute(List<StopModel> stops) async {
    if (stops.length < 2) return;

    final ida = await _getRoute(
      origin: stops.first,
      destination: stops.last,
      waypoints: stops.length > 2 ? stops.sublist(1, stops.length - 1) : [],
    );

    final regresoStops = stops.reversed.toList();

    final regreso = await _getRoute(
      origin: regresoStops.first,
      destination: regresoStops.last,
      waypoints: regresoStops.length > 2
          ? regresoStops.sublist(1, regresoStops.length - 1)
          : [],
    );

    if (!mounted) return;

    setState(() {
      polylines = {
        if (ida.isNotEmpty)
          Polyline(
            polylineId: const PolylineId("ida"),
            color: Colors.blue,
            width: 5,
            points: ida,
          ),
        if (regreso.isNotEmpty)
          Polyline(
            polylineId: const PolylineId("regreso"),
            color: Colors.blue,
            width: 5,
            points: regreso,
          ),
      };

      _busRoutePoints = ida;
      _busIndex = 0;
    });
  }

  bool _routeChanged(List<StopModel> stops) {
    if (_lastStops.isEmpty) return true;
    if (stops.length != _lastStops.length) return true;
    if (stops.first.id != _lastStops.first.id) return true;
    if (stops.last.id != _lastStops.last.id) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return ValueListenableBuilder<List<StopModel>>(
      valueListenable: RouteSelectedState.stopsNotifier,
      builder: (context, stops, _) {

        if (stops.isNotEmpty && _routeChanged(stops)) {
          _lastStops = List.from(stops);

          WidgetsBinding.instance.addPostFrameCallback((_) {
            _buildRoute(stops);
            _startBusSimulation();
          });
        }

        if (stops.isEmpty) {
          _busMarkers = {};
          _busRoutePoints = [];
          _busIndex = 0;
          _busSelected = false;
        }

        return GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _initialPosition,
            zoom: 14,
          ),
          onMapCreated: _onMapCreated,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          zoomControlsEnabled: false,
          polylines: polylines,
          markers: _busMarkers,
        );
      },
    );
  }
}