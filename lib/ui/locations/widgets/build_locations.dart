import 'build_location.dart';
import 'package:app/app/blocs.dart';
import 'package:flutter/material.dart';
import 'package:app/core/injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildLocations extends StatelessWidget {
  const BuildLocations({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        getIt<LocationsBloc>().add(
          const LocationsEvent.refreshCollection(),
        );
      },
      child: BlocBuilder<LocationsBloc, LocationsState>(
        builder: (_, state) {
          final locations = state.locations;
          if (locations.isEmpty) return _buildEmptyText();
          return ListView.separated(
            itemCount: locations.length,
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height),
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (ctx, index) {
              final location = locations[index];
              return BuildLocation(
                index: index,
                key: ValueKey(index),
                locationData: location,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildEmptyText() {
    return Center(
      child: Text(
        "Empty",
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w500,
          color: Colors.grey.shade300,
        ),
      ),
    );
  }
}
