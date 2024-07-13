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
      getIt<PermissionBloc>().add(const PermissionEvent.checkLocationPermission());
      await Future.delayed(const Duration(seconds: 2), () {
        final locationState = getIt<PermissionBloc>().state.locationState;
        if (locationState == LocationState.permissionGrantedServiceOn) {
          context.go(LocationsView.route);
        } else {
          context.go(PermissionsView.route);
        }
      });
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
