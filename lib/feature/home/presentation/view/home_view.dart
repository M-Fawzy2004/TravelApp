import 'package:flutter/material.dart';
import 'package:travel_app/feature/home/presentation/view/widget/custom_add_travel.dart';
import 'package:travel_app/feature/home/presentation/view/widget/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: CustomAddTravel(),
      body: SafeArea(
        child: HomeViewBody(),
      ),
    );
  }
}
