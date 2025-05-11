// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:travel_app/feature/home/presentation/view/passenger_view/view/widget/passenger_home_view_body.dart';

class PassengerHomeView extends StatelessWidget {
  const PassengerHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      body: SafeArea(
        child: PassengerHomeViewBody(),
      ),
    );
  }
}
