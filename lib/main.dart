import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/helper/custom_bloc_observer.dart';
import 'package:travel_app/firebase_options.dart';
import 'package:travel_app/travel_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = CustomBlocObserver();
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => TravelApp(),
    ),
  );
}
