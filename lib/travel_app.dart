// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:travel_app/core/helper/app_router.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/widget/custom_loading_circle.dart';

class TravelApp extends StatelessWidget {
  const TravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(440, 956),
      minTextAdapt: true,
      builder: (context, child) {
        return GlobalLoaderOverlay(
          overlayColor: Colors.black.withOpacity(0.5),
          overlayWholeScreen: true,
          useDefaultLoading: false,
          overlayWidgetBuilder: (_) => const Center(
            child: CustomLoadingCircle(),
          ),
          child: MaterialApp.router(
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('ar')],
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouter.router,
            theme: ThemeData(
              fontFamily: 'font',
              brightness: Brightness.light,
              primaryColor: AppColors.primaryColor,
              scaffoldBackgroundColor: AppColors.grey,
              appBarTheme: const AppBarTheme(
                backgroundColor: AppColors.grey,
                foregroundColor: AppColors.black,
                elevation: 0,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.dark,
                ),
              ),
              cardColor: AppColors.white,
              dividerColor: AppColors.lightGrey,
              textTheme: const TextTheme(
                bodyLarge: TextStyle(color: AppColors.black),
                bodyMedium: TextStyle(color: AppColors.black),
                titleLarge: TextStyle(color: AppColors.black),
                titleMedium: TextStyle(color: AppColors.black),
              ),
              colorScheme: const ColorScheme.light(
                primary: AppColors.primaryColor,
                surface: AppColors.white,
                background: AppColors.grey,
                onPrimary: AppColors.white,
                onSurface: AppColors.black,
                onBackground: AppColors.black,
              ),
            ),
            darkTheme: ThemeData(
              fontFamily: 'font',
              brightness: Brightness.dark,
              primaryColor: AppColors.darkPrimaryColor,
              scaffoldBackgroundColor: AppColors.darkBackgroundColor,
              appBarTheme: const AppBarTheme(
                backgroundColor: AppColors.darkBackgroundColor,
                foregroundColor: AppColors.darkTextColor,
                elevation: 0,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.light,
                ),
              ),
              cardColor: AppColors.darkSurfaceColor,
              dividerColor: AppColors.darkLightGrey,
              textTheme: const TextTheme(
                bodyLarge: TextStyle(color: AppColors.darkTextColor),
                bodyMedium: TextStyle(color: AppColors.darkTextColor),
                titleLarge: TextStyle(color: AppColors.darkTextColor),
                titleMedium: TextStyle(color: AppColors.darkTextColor),
              ),
              colorScheme: const ColorScheme.dark(
                primary: AppColors.darkPrimaryColor,
                surface: AppColors.darkSurfaceColor,
                background: AppColors.darkBackgroundColor,
                onPrimary: AppColors.black,
                onSurface: AppColors.darkTextColor,
                onBackground: AppColors.darkTextColor,
              ),
            ),
            themeMode: ThemeMode.system,
          ),
        );
      },
    );
  }
}
