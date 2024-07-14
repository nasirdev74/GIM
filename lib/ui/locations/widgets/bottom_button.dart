import 'primary_button.dart';
import 'package:app/app/blocs.dart';
import 'package:flutter/material.dart';
import 'package:app/core/injector.dart';

class BottomActionButton extends StatelessWidget {
  const BottomActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(top: 10, bottom: 20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: PrimaryButton(
                  label: "Stop",
                  activeColor: Colors.red,
                  onTap: () => {
                    getIt<LocationsBloc>().add(
                      const LocationsEvent.stopCollection(),
                    ),
                  },
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: PrimaryButton(
                  label: "Start",
                  activeColor: Colors.green,
                  onTap: () => {
                    getIt<LocationsBloc>().add(
                      const LocationsEvent.startCollection(),
                    ),
                  },
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: PrimaryButton(
                  label: "Clear",
                  activeColor: Colors.red,
                  onTap: () => {
                    getIt<LocationsBloc>().add(
                      const LocationsEvent.clearAll(),
                    ),
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
