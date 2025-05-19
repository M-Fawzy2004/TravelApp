import 'package:flutter/material.dart';
import 'package:travel_app/feature/home/presentation/view/ride_view/presentation/view/passenger_directory/presentation/view/widget/passenger_directory_view_body.dart';

class PassengerDirectoryView extends StatelessWidget {
  const PassengerDirectoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: PassengerDirectoryViewBody()),
    );
  }
}
