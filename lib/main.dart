import 'core/injector.dart';
import 'package:app/app/blocs.dart';
import 'package:app/core/router.dart';
import 'package:flutter/material.dart';
import 'package:app/core/app.settings.dart';
import 'package:app/core/bloc_observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async => await initApp();

Future initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppSettings.init();
  configureDependencies();
  Bloc.observer = MyBlocObserver();
  runApp(const GIMTestApp());
}

class GIMTestApp extends StatefulWidget {
  const GIMTestApp({super.key});

  @override
  State<GIMTestApp> createState() => _GIMTestAppState();
}

class _GIMTestAppState extends State<GIMTestApp> {
  final router = AppRouter.router();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (ctx) => getIt<PermissionBloc>()),
        BlocProvider(create: (ctx) => getIt<LocationsBloc>()),
      ],
      child: MaterialApp.router(
        title: "Test App",
        debugShowCheckedModeBanner: false,
        routerDelegate: router.routerDelegate,
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
      ),
    );
  }
}
