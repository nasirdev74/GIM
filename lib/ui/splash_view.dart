import 'package:app/ui/views.dart';
import 'package:app/app/blocs.dart';
import 'package:app/enum/enums.dart';
import 'package:flutter/material.dart';
import 'package:app/core/injector.dart';
import 'package:go_router/go_router.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  static const route = "/";

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 500));
      final permissionBloc = getIt<PermissionBloc>();
      permissionBloc.add(const PermissionEvent.checkLocationPermission());
      permissionBloc.add(const PermissionEvent.checkBatteryOptimizationPermission());
      await Future.delayed(const Duration(seconds: 1));
      final locationState = permissionBloc.state.locationState;
      final batteryOptimizationGranted = permissionBloc.state.batteryOptimizationGranted;
      if (locationState == LocationState.permissionGrantedServiceOn && batteryOptimizationGranted) {
        context.go(LocationsView.route);
      } else {
        context.go(PermissionsView.route);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF022e45),
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(200),
          child: Image.asset(
            "assets/logo.png",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
