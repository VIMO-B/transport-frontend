import 'package:flutter/material.dart';
import 'widgets/agency_card.dart';

class AgenciesScreen extends StatelessWidget {
  const AgenciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final agencies = [
      "Metrolínea - Pretroncalés",
      "TPC - Transpiedecuesta S.A.",
      "Metrolínea - Rutas directas",
      "TPC - Transgirón S.A.",
      "TPC - Cotrander",
      "TPC - Lusitania S.A."
    ];

    return Scaffold(
      body: Column(
        children: [

          /// HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFE91E63),
                  Color(0xFFD4145A),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Center(
              child: Image.asset(
                'assets/images/logo_vimo.webp',
                height: 50,
              ),
            ),
          ),

          const SizedBox(height: 24),

          /// TITULO
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Agencias disponibles",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600, // SemiBold
                  color: Color(0xFF1C1C1C),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          /// LISTA
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: agencies.length,
              itemBuilder: (context, index) {
                return AgencyCard(
                  name: agencies[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
