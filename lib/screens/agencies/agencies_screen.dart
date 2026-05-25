import 'package:flutter/material.dart';

import 'widgets/agency_card.dart';
import '../home/home_screen.dart';

import '../../models/agency_model.dart';
import '../../services/api/agency_service.dart';
import '../../services/ads/banner_ad_widget.dart';

import '../../state/agency_state.dart';
import '../../state/route_selected_state.dart'; // 🔥 IMPORTANTE

class AgenciesScreen extends StatefulWidget {
  const AgenciesScreen({super.key});

  @override
  State<AgenciesScreen> createState() => _AgenciesScreenState();
}

class _AgenciesScreenState extends State<AgenciesScreen> {
  late Future<List<Agency>> _futureAgencies;

  @override
  void initState() {
    super.initState();
    _futureAgencies = AgencyService.getAgencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          /// HEADER (NO TOCADO)
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

          /// TITULO (NO TOCADO)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Agencias disponibles",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1C1C1C),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          /// LISTA BACKEND
          Expanded(
            child: FutureBuilder<List<Agency>>(
              future: _futureAgencies,
              builder: (context, snapshot) {

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error: ${snapshot.error}"),
                  );
                }

                final agencies = snapshot.data ?? [];

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: agencies.length,
                  itemBuilder: (context, index) {
                    final agency = agencies[index];

                    return AgencyCard(
                      name: agency.name,
                      onSelect: () {

                        if (agency.id == null) return;

                        /// 🔥 AQUÍ ESTÁ LA SOLUCIÓN
                        RouteSelectedState.clear();

                        /// guardar agencia
                        AgencyState.clear();
                        AgencyState.setAgency(agency);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HomeScreen(),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),

          /// BANNER (NO TOCADO)
          const BannerAdWidget(),
        ],
      ),
    );
  }
}