// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:travel_app/core/helper/app_router.dart';
import 'package:travel_app/core/theme/app_color.dart';

class TravelApp extends StatelessWidget {
  const TravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return ScreenUtilInit(
      designSize: const Size(440, 956),
      minTextAdapt: true,
      builder: (context, child) {
        return GlobalLoaderOverlay(
          overlayColor: Colors.black.withOpacity(0.5),
          overlayWholeScreen: true,
          useDefaultLoading: false,
          overlayWidgetBuilder: (_) => Center(
            child: SpinKitCircle(
              color: AppColors.primaryColor,
              size: 50.h,
            ),
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
              appBarTheme: const AppBarTheme(
                color: AppColors.grey,
              ),
              primaryColor: AppColors.primaryColor,
              scaffoldBackgroundColor: AppColors.grey,
            ),
            darkTheme: ThemeData.dark(),
          ),
        );
      },
    );
  }
}
