import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/app_router.dart';
import 'package:travel_app/core/theme/app_color.dart';

class TravelApp extends StatelessWidget {
  const TravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return ScreenUtilInit(
      designSize: const Size(440, 956),
      minTextAdapt: true,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
        theme: ThemeData(
          fontFamily: 'font',
          primaryColor: AppColors.primaryColor,
          scaffoldBackgroundColor: AppColors.white,
        ),
      ),
    );
  }
}
