import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BusBottomSheet extends StatelessWidget {
  final bool isActive;

  const BusBottomSheet({
    super.key,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    final fecha = DateFormat('d MMMM', 'es_ES').format(now);
    final hora = DateFormat('hh:mm a').format(now);

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF2B2B2B),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // =====================
          // HANDLE
          // =====================
          Container(
            width: 100,
            height: 5,
            margin: const EdgeInsets.only(top: 12, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          // =====================
          // FECHA / HORA (UNA SOLA VEZ)
          // =====================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(fecha,
                    style: const TextStyle(color: Colors.white)),
                Text(hora,
                    style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // =====================
          // CARD HTML CONVERTIDA
          // =====================
          if (isActive)
            Container(
              width: 360,
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HEADER
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFE5487E),
                          Color(0xFFF2C4CF),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      "Transpiedecuesta",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ROW
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4D6DF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          "TTV 889",
                          style: TextStyle(
                            color: Color(0xFFE5487E),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Text(
                        "5am - 9pm",
                        style: TextStyle(
                          color: Color(0xFFE5487E),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Container(height: 1, color: const Color(0xFFE5E5E5)),

                  const SizedBox(height: 16),

                  // ROUTE
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: Color(0xFFE5487E),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "Piedecuesta - Girón",
                        style: TextStyle(
                          color: Color(0xFF666666),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Container(height: 1, color: const Color(0xFFE5E5E5)),

                  const SizedBox(height: 12),

                  const Text(
                    "\$ 3.600",
                    style: TextStyle(
                      color: Color(0xFFE5487E),
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
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