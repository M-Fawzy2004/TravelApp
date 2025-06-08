import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/helper/custom_bloc_observer.dart';
import 'package:travel_app/core/services/auth_service.dart';
import 'package:travel_app/core/services/get_it_setup.dart';
import 'package:travel_app/core/services/shared_preference_singleton.dart';
import 'package:travel_app/feature/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:travel_app/feature/position_bus/presentation/manager/cubit/comment_cubit.dart';
import 'package:travel_app/firebase_options.dart';
import 'package:travel_app/travel_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = CustomBlocObserver();
  setupServiceLocator();
  await Prefs.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(
            getIt<AuthService>(),
          ),
        ),
        BlocProvider(
          create: (context) => CommentCubit(),
        ),
      ],
      child: DevicePreview(
        enabled: false,
        builder: (context) => const TravelApp(),
      ),
    ),
  );
}
