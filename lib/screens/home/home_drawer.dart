import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'widgets/route_item.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key, required agency});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFF2F2F2),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 64),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔥 LOGO
              SvgPicture.asset(
                "assets/images/logo_vimo_deg.svg",
                width: 153,
              ),

              const SizedBox(height: 24),

              /// 🌈 TITULO GRADIENTE
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFDA1457),
                    Color(0xFFFF92AC),
                  ],
                  stops: [0.4158, 0.8745],
                ).createShader(bounds),
                child: const Text(
                  "Todas las rutas",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              /// 🔘 SEPARADOR
              Container(
                height: 1,
                color: const Color(0xFFDBDBDB),
              ),

              const SizedBox(height: 8),

              /// 📍 LISTA
              Expanded(
                child: ListView(
                  children: const [
                    RouteItem(
                      code: "P1",
                      routeName: "La cumbre - Centro",
                    ),
                    RouteItem(
                      code: "P3",
                      routeName: "Caracolí - Parque Estación U.I.S",
                    ),
                    RouteItem(
                      code: "RD15",
                      routeName:
                          "Parque Estación UIS - Centro - Portal del Valle",
                    ),
                    RouteItem(
                      code: "RD27",
                      routeName: "Portal del Valle - Carrera 27 - UIS",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}