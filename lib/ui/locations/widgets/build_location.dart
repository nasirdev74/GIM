import 'package:intl/intl.dart';
import 'package:app/ui/views.dart';
import 'package:app/app/blocs.dart';
import 'package:flutter/material.dart';
import 'package:app/core/injector.dart';
import 'package:app/models/models.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class BuildLocation extends StatelessWidget {
  const BuildLocation({super.key, required this.index, required this.locationData});

  final int index;
  final LocationData locationData;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: index.isOdd ? Colors.grey.shade200 : Colors.white,
      child: InkWell(
        onTap: () => {},
        child: Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (_) => getIt<LocationsBloc>().add(
                  LocationsEvent.deleteCollection(
                    id: locationData.id,
                  ),
                ),
                backgroundColor: Colors.red.shade600,
                foregroundColor: Colors.white,
                icon: Icons.delete,
              ),
              SlidableAction(
                onPressed: (_) => context.pushNamed(
                  LocationView.route,
                  extra: locationData,
                ),
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                icon: Icons.location_on,
              ),
            ],
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 12,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(locationData.id.toString()),
                    const SizedBox(width: 10),
                    Text(locationData.latitude.toString()),
                    const SizedBox(width: 10),
                    Text(locationData.longitude.toString()),
                    const SizedBox(width: 10),
                    Text(
                      "at ${DateFormat("hh:mm:ss a").format(DateTime.fromMillisecondsSinceEpoch(locationData.timestamp))}",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
