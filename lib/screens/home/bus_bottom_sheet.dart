import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BusBottomSheet extends StatelessWidget {
  const BusBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    final fecha = DateFormat('d MMMM', 'es_ES').format(now);
    final hora = DateFormat('hh:mm a').format(now);

    return Container(
      height: 80,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF2B2B2B),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start, // 🔥 clave
        children: [
          /// 🔘 HANDLE (más arriba)
          Container(
            width: 100,
            height: 5,
            margin: const EdgeInsets.only(top: 12, bottom: 10), // 🔥 controla posición
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          /// 📅 FECHA Y HORA
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  fecha,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                Text(
                  hora,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}