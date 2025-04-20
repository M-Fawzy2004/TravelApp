import 'package:flutter/material.dart';
import 'package:travel_app/feature/home/presentation/view/widget/details_trip_view_body.dart';

class DetailsTripView extends StatelessWidget {
  const DetailsTripView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DetailsTripViewBody(),
    );
  }
}
