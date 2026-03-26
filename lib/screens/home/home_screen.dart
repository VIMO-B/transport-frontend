import 'package:flutter/material.dart';
import '../../models/agency_model.dart';
import 'home_drawer.dart';
import 'map_section.dart';
import 'bus_bottom_sheet.dart';
import '../agencies/agencies_screen.dart';

class HomeScreen extends StatelessWidget {
  final Agency agency;

  const HomeScreen({super.key, required this.agency});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeDrawer(agency: agency),

      body: Stack(
        children: [
          const MapSection(),

          /// 🔴 HEADER VIMO
          SafeArea(
            child: Builder(
              builder: (context) => Container(
                height: 100,
                child: Stack(
                  children: [
                    /// 🎨 GRADIENTE BASE
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color(0xFFE91E63),
                            Color(0xFFFF6F91),
                          ],
                        ),
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(28),
                        ),
                      ),
                    ),

                    /// 🎨 OVERLAY
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            Colors.transparent,
                            Color(0xFFFF5252).withOpacity(0.6),
                          ],
                          stops: const [0.5, 1.0],
                        ),
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(28),
                        ),
                      ),
                    ),

                    /// 🔥 CONTENIDO ABAJO
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        child: Row(
                          children: [
                            /// ☰ MENU
                            IconButton(
                              icon: const Icon(
                                Icons.menu,
                                color: Colors.white,
                                size: 26,
                              ),
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                            ),

                            const Spacer(),

                            /// 🟣 LOGO
                            Image.asset(
                              "assets/images/logo_vimo.webp",
                              height: 34,
                            ),

                            const Spacer(),

                            /// 🚪 LOGOUT FUNCIONAL
                            IconButton(
                              icon: const Icon(
                                Icons.logout,
                                color: Colors.white,
                                size: 26,
                              ),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => AgenciesScreen(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// ⬇️ PANEL INFERIOR
          const Align(
            alignment: Alignment.bottomCenter,
            child: BusBottomSheet(),
          ),
        ],
      ),
    );
  }
}