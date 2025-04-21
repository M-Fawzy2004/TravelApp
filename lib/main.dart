import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/helper/custom_bloc_observer.dart';
import 'package:travel_app/core/services/auth_service.dart';
import 'package:travel_app/core/services/get_it_setup.dart';
import 'package:travel_app/feature/login/presentation/manager/cubit/auth_cubit.dart';
import 'package:travel_app/firebase_options.dart';
import 'package:travel_app/travel_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = CustomBlocObserver();
  setupServiceLocator();
  runApp(
    BlocProvider(
      create: (context) => AuthCubit(
        getIt<AuthService>(),
      ),
      child: DevicePreview(
        enabled: false,
        builder: (context) => TravelApp(),
      ),
    ),
  );
}
