import 'package:intl/intl.dart';
import 'package:app/ui/views.dart';
import 'package:app/app/blocs.dart';
import 'package:flutter/material.dart';
import 'package:app/core/injector.dart';
import 'package:go_router/go_router.dart';
import 'package:app/local_database/db_position.dart';

class BuildLocation extends StatelessWidget {
  const BuildLocation({super.key, required this.position});

  final DBPosition position;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("lat: ${position.latitude.toStringAsFixed(3)}"),
                      Text("long: ${position.longitude.toStringAsFixed(3)}"),
                      Text("date: ${DateFormat("dd MMM").format(position.dateTime)}"),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Material(
                  color: Colors.red.shade900,
                  child: InkWell(
                    onTap: () => getIt<LocationsBloc>().add(
                      LocationsEvent.deleteCollection(
                        id: position.id ?? 0,
                      ),
                    ),
                    child: SizedBox(
                      height: 45,
                      width: MediaQuery.of(context).size.width / 2,
                      child: const Center(
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("alt: ${position.altitude.toStringAsFixed(3)}"),
                      Text("accuracy: ${position.accuracy.toInt()}"),
                      Text("time: ${DateFormat("hh:mm:ss").format(position.dateTime)}"),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Material(
                  color: Colors.purple,
                  child: InkWell(
                    onTap: () => context.pushNamed(
                      LocationView.route,
                      extra: position,
                    ),
                    child: SizedBox(
                      height: 45,
                      width: MediaQuery.of(context).size.width / 2,
                      child: const Center(
                        child: Icon(
                          Icons.location_on,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
