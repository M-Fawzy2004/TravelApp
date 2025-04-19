import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // مهم للاهتزاز
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: screenIndex,
        type: BottomNavigationBarType.shifting,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        selectedItemColor: AppColors.black,
        unselectedItemColor: AppColors.grey,
        onTap: (index) {
          HapticFeedback.lightImpact();
          setState(() {
            screenIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسيه',
            backgroundColor: AppColors.primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'المضاف مؤخرا',
            backgroundColor: AppColors.primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'الرسائل',
            backgroundColor: AppColors.primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'الملف الشخصي',
            backgroundColor: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}
