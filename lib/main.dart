import 'core/injector.dart';
import 'package:app/app/blocs.dart';
import 'package:app/core/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:app/firebase_options.dart';
import 'package:app/core/app.settings.dart';
import 'package:app/core/bloc_observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() async => await initApp(prod: false);

Future initApp({bool prod = true}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: prod ? "prod.env" : "dev.env");
  AppSettings.init();
  configureDependencies();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(kReleaseMode);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

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
