// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:travel_app/feature/home/presentation/view/widget/passenger_home_view_body.dart';

class PassengerHomeView extends StatelessWidget {
  const PassengerHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      body: SafeArea(
        child: PassengerHomeViewBody(),
      ),
    );
  }
}
