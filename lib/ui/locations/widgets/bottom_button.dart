import 'primary_button.dart';
import 'package:app/app/blocs.dart';
import 'package:flutter/material.dart';
import 'package:app/core/injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomActionButton extends StatelessWidget {
  const BottomActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationsBloc, LocationsState>(
      builder: (ctx, state) {
        return Positioned(
          bottom: 0,
          child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 10, bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                state.periodicCollectionRunning
                    ? PrimaryButton(
                        label: "Stop Collection",
                        activeColor: Colors.red,
                        onTap: () => {
                          getIt<LocationsBloc>().add(
                            const LocationsEvent.stopCollection(),
                          ),
                        },
                      )
                    : PrimaryButton(
                        label: "Start Collection",
                        activeColor: Colors.green,
                        onTap: () => {
                          getIt<LocationsBloc>().add(
                            const LocationsEvent.startCollection(),
                          ),
                        },
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
