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
          final positions = state.positions;
          if (positions.isEmpty) return _buildEmptyText();
          return ListView.separated(
            itemCount: positions.length,
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 200),
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (ctx, index) {
              final position = positions[index];
              return BuildLocation(position: position);
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
