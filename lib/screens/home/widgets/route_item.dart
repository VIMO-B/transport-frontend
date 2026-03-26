import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RouteItem extends StatelessWidget {
  final String routeName;
  final String code;

  const RouteItem({
    super.key,
    required this.routeName,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              /// 🚌 ICONO + CODIGO (CON INDICADOR ABAJO)
              Stack(
                children: [
                  /// 🔲 CONTENEDOR PRINCIPAL
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: const Color(0xFFD0D0D0), // 🔥 stroke
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/images/icon_bus.svg",
                          width: 18,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          code,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// 🔻 LINEA ROSA (ABSOLUTA)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 3,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF005E),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(6),
                          bottomRight: Radius.circular(6),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 12),

              /// 📝 NOMBRE RUTA
              Expanded(
                child: Text(
                  routeName,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),

        /// 🔘 SEPARADOR REAL
        Container(
          height: 1,
          color: const Color(0xFFDBDBDB),
        ),
      ],
    );
  }
}