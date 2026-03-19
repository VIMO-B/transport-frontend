import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AgencyCard extends StatelessWidget {
  final String name;

  const AgencyCard({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEFEFEF),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          /// ICONO SVG (sin fondo negro)
          SizedBox(
            width: 40, // mantiene alineación limpia
            child: SvgPicture.asset(
              'assets/images/bus_icon.svg',
              height: 35,
            ),
          ),

          const SizedBox(width: 12),

          /// TEXTOS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// NOMBRE DE LA AGENCIA
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600, // SemiBold
                    color: Color(0xFF4D4D4D),
                  ),
                ),

                const SizedBox(height: 4),

                /// HORARIO
                const Text(
                  "5am - 9pm",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500, // Medium
                    color: Color(0xFF727272),
                  ),
                ),
              ],
            ),
          ),

          /// BOTÓN
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD4145A),
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              // Aquí luego navegamos al Home
            },
            child: const Text(
              "Seleccionar",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500, // Medium
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
