import 'package:app/app/blocs.dart';
import 'package:app/enum/enums.dart';
import 'package:flutter/material.dart';
import 'package:app/core/injector.dart';
import 'package:go_router/go_router.dart';
import 'package:app/ui/permissions_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/ui/locations/widgets/widgets.dart';

class LocationsView extends StatefulWidget {
  const LocationsView({super.key});

  static const route = "/locations";

  @override
  State<LocationsView> createState() => _LocationsViewState();
}

class _LocationsViewState extends State<LocationsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getIt<LocationsBloc>().add(const LocationsEvent.refreshCollection());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PermissionBloc, PermissionState>(
      listener: (ctx, state) {
        if (state.locationState != LocationState.permissionGrantedServiceOn) {
          getIt<LocationsBloc>().add(const LocationsEvent.stopCollection());
          context.go(PermissionsView.route);
        }
      },
      child: const Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              BuildLocations(),
              BottomActionButton(),
            ],
          ),
        ),
      ),
    );
  }
}
