import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/route_model.dart';
import '../../services/api/route_service.dart';
import '../../state/agency_state.dart';
import 'widgets/route_item.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  late Future<List<RouteModel>> _routesFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadRoutes();
  }

  void _loadRoutes() {
    final agencyId = AgencyState.getAgencyId();

    if (agencyId == null) {
      _routesFuture = Future.value([]);
      return;
    }

    _routesFuture = RouteService.getRoutesByCompany(agencyId);
  }

  @override
  Widget build(BuildContext context) {
    final agencyName = AgencyState.getAgencyName();

    return Drawer(
      backgroundColor: const Color(0xFFF2F2F2),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SvgPicture.asset(
                "assets/images/logo_vimo_deg.svg",
                width: 120,
              ),

              const SizedBox(height: 24),

              Text(
                agencyName ?? "",
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),

              const SizedBox(height: 10),

              const Text(
                "Todas las rutas",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 10),

              Container(height: 1, color: const Color(0xFFDBDBDB)),

              const SizedBox(height: 10),

              Expanded(
                child: FutureBuilder<List<RouteModel>>(
                  future: _routesFuture,
                  builder: (context, snapshot) {

                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Error: ${snapshot.error}"),
                      );
                    }

                    final routes = snapshot.data ?? [];

                    return ListView.builder(
                      itemCount: routes.length,
                      itemBuilder: (context, index) {
                        final route = routes[index];

                        return RouteItem(
                          routeId: route.id,
                          code: route.code,
                          routeName: route.name,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}