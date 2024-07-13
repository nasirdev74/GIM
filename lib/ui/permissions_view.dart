import 'package:app/ui/views.dart';
import 'package:app/app/blocs.dart';
import 'package:flutter/material.dart';
import 'package:app/core/injector.dart';
import 'package:go_router/go_router.dart';
import 'package:app/enum/location_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'locations/widgets/primary_button.dart';

class PermissionsView extends StatelessWidget {
  const PermissionsView({super.key});

  static const route = "/permissions";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: BlocConsumer<PermissionBloc, PermissionState>(
          listener: (ctx, state) {
            if (state.locationState == LocationState.permissionGrantedServiceOn) {
              context.go(LocationsView.route);
            }
          },
          builder: (_, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Location permission and service action"),
                const SizedBox(height: 50),
                PrimaryButton(
                  label: () {
                    switch (state.locationState) {
                      case LocationState.noPermission:
                        return "Request Permission";
                      case LocationState.permissionDeniedForever:
                        return "Open Settings";
                      case LocationState.permissionGrantedServiceOff:
                        return "Enable Service";
                      case LocationState.permissionGrantedServiceOn:
                        return "Service Available";
                    }
                  }(),
                  activeColor: Colors.red,
                  onTap: () => {
                    getIt<PermissionBloc>().add(
                      const PermissionEvent.requestLocationPermission(),
                    ),
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
