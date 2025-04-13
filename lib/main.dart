import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/helper/custom_bloc_observer.dart';
import 'package:travel_app/travel_app.dart';

void main() async {
  Bloc.observer = CustomBlocObserver();

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => TravelApp(), 
    ),
  );
}
