import 'package:flutter/material.dart';

import '../../../services/api/route_stops_service.dart';
import '../../../state/route_selected_state.dart';

class RouteItem extends StatelessWidget {
  final int routeId;
  final String code;
  final String routeName;

  const RouteItem({
    super.key,
    required this.routeId,
    required this.code,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        try {
          final stops =
              await RouteStopsService.getStopsByRoute(routeId);

          RouteSelectedState.setStops(stops);

          
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: $e")),
          );
        }
      },

      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 🚌 BLOQUE IZQUIERDO (ICONO + BADGE + LINEA ROJA)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                /// ICONO + CÓDIGO
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.directions_bus,
                        size: 16,
                        color: Colors.black87,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        code,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                /// 🔴 LÍNEA ROJA PEGADA ABAJO (DENTRO DEL BLOQUE)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  height: 3,
                  width: 52, // mismo ancho visual del bloque
                  decoration: const BoxDecoration(
                    color: Color(0xFFE91E63),
                    borderRadius: BorderRadius.all(
                      Radius.circular(2),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 12),

            /// 📍 TEXTO DERECHA
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  routeName,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}