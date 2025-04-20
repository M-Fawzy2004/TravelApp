// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/feature/home/presentation/view/home_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int screenIndex = 0;

  final List<Widget> screens = [
    HomeView(),
    Center(
      child: Text("المضاف مؤخرا"),
    ),
    Center(
      child: Text("الرسائل"),
    ),
    Center(
      child: Text("الملف الشخصي"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[screenIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.grey,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6,
              spreadRadius: 0,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: screenIndex,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          iconSize: 17.sp,
          selectedIconTheme: IconThemeData(size: 20.sp),
          selectedFontSize: 14.sp,
          unselectedFontSize: 12.sp,
          backgroundColor: Colors.transparent,
          selectedItemColor: AppColors.black,
          unselectedItemColor: Colors.black45,
          onTap: (index) {
            HapticFeedback.lightImpact();
            setState(() {
              screenIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.home),
              label: 'الرئيسيه',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.car),
              label: 'المضاف مؤخرا',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.facebookMessenger),
              label: 'الرسائل',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.user),
              label: 'الملف الشخصي',
            ),
          ],
        ),
      ),
    );
  }
}
