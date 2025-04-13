import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:travel_app/core/helper/app_router.dart';
import 'package:travel_app/core/theme/app_theme/dark_mode.dart';
import 'package:travel_app/core/theme/app_theme/light_mode.dart';
import 'package:travel_app/core/theme/app_theme/theme_app_provider.dart';

class TravelApp extends StatelessWidget {
  const TravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeAppProvider>();

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            themeProvider.isDarkMode ? Brightness.light : Brightness.dark,
        statusBarBrightness:
            themeProvider.isDarkMode ? Brightness.dark : Brightness.light,
      ),
    );

    return ScreenUtilInit(
      designSize: const Size(440, 956),
      minTextAdapt: true,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        routerConfig: AppRouter.router,
        theme: lightMode,
        darkTheme: darkMode,
        themeMode: themeProvider.themeMode,
      ),
    );
  }
}
