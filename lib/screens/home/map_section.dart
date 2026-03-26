import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapSection extends StatefulWidget {
  const MapSection({super.key});

  @override
  State<MapSection> createState() => _MapSectionState();
}

class _MapSectionState extends State<MapSection> {
  GoogleMapController? _mapController;
  LatLng? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return;
      }

      Position position = await Geolocator.getCurrentPosition();

      if (!mounted) return; // 🔥 evita error de dispose

      _currentPosition = LatLng(position.latitude, position.longitude);

      setState(() {});

      if (_mapController != null) {
        _mapController!.animateCamera(
          CameraUpdate.newLatLngZoom(_currentPosition!, 16),
        );
      }
    } catch (e) {
      debugPrint("Error obteniendo ubicación: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    /// 🌐 WEB → evitar error de Google Maps
    if (kIsWeb) {
      return const Center(
        child: Text(
          "Mapa no disponible en web",
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    /// 📱 ANDROID / iOS → mapa real
    return GoogleMap(
      initialCameraPosition: const CameraPosition(
        target: LatLng(7.1193, -73.1227), // Bucaramanga fallback
        zoom: 14,
      ),
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      onMapCreated: (controller) {
        _mapController = controller;
      },
      markers: _currentPosition == null
          ? {}
          : {
              Marker(
                markerId: const MarkerId("user"),
                position: _currentPosition!,
              )
            },
    );
  }
}