import 'package:flutter/material.dart';
import 'package:travel_app/feature/position_bus/data/model/governorate_model.dart';
import 'package:travel_app/feature/position_bus/presentation/view/widget/station_routes_screen_body.dart';

class StationRoutesScreen extends StatelessWidget {
  final Station station;

  const StationRoutesScreen({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: StationRoutesScreenBody(station: station),
      ),
    );
  }
}
