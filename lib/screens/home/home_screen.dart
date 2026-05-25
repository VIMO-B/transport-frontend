import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_drawer.dart';
import 'map_section.dart';
import 'bus_bottom_sheet.dart';
import '../agencies/agencies_screen.dart';

import '../../state/route_selected_state.dart'; // 🔥 IMPORTANTE
import '../../state/agency_state.dart'; // 🔥 IMPORTANTE

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final statusBar = MediaQuery.of(context).padding.top;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,

        /// ✔ Drawer (igual)
        drawer: const HomeDrawer(),

        body: Stack(
          children: [
            const MapSection(),

            /// 🔴 HEADER ORIGINAL (NO TOCADO)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Builder(
                builder: (context) {
                  return SizedBox(
                    height: statusBar + 90,
                    child: Stack(
                      children: [
                        /// FONDO
                        Container(
                          height: statusBar + 90,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color(0xFFDA1457),
                                Color(0xFFFF92AC),
                              ],
                            ),
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(28),
                            ),
                          ),
                        ),

                        /// CONTENIDO
                        Padding(
                          padding: EdgeInsets.only(top: statusBar),
                          child: Align(
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
                                    icon: const Icon(Icons.menu,
                                        color: Colors.white),
                                    onPressed: () {
                                      Scaffold.of(context).openDrawer();
                                    },
                                  ),

                                  const Spacer(),

                                  /// LOGO
                                  Image.asset(
                                    "assets/images/logo_vimo.webp",
                                    height: 34,
                                  ),

                                  const Spacer(),

                                  /// 🚪 LOGOUT (SOLO AQUÍ CAMBIAMOS LÓGICA)
                                  IconButton(
                                    icon: const Icon(Icons.logout,
                                        color: Colors.white),
                                    onPressed: () {

                                      /// 🔥 LIMPIAR RUTA (CLAVE DEL BUG)
                                      RouteSelectedState.clear();

                                      /// opcional
                                      AgencyState.clear();

                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              const AgenciesScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            /// ⬇️ PANEL INFERIOR (IGUAL)
            const Align(
              alignment: Alignment.bottomCenter,
              child: BusBottomSheet(),
            ),
          ],
        ),
      ),
    );
  }
}