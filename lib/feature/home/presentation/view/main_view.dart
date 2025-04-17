// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:travel_app/feature/home/presentation/view/home_view.dart';
import 'package:travel_app/feature/home/presentation/view/widget/custom_navigation_bar.dart';

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
      child: Text("resent"),
    ),
    Center(
      child: Text("message"),
    ),
    Center(
      child: Text("profile"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavigationBar(
        onTabChange: (index) {
          setState(() {
            screenIndex = index;
          });
        },
      ),
      body: screens[screenIndex],
    );
  }
}
