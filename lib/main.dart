import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/core/helper/custom_bloc_observer.dart';
import 'package:travel_app/core/theme/app_theme/theme_app_provider.dart';
import 'package:travel_app/travel_app.dart';

void main() async {
  Bloc.observer = CustomBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      startLocale: const Locale('ar'),
      child: ChangeNotifierProvider(
        create: (_) => ThemeAppProvider(),
        child: const TravelApp(),
      ),
    ),
  );
}
