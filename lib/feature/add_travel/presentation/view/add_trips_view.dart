import 'package:flutter/material.dart';
import 'package:travel_app/feature/travel/presentation/view/widget/add_trips_view_body.dart';

class AddTripsView extends StatelessWidget {
  const AddTripsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AddTripsViewBody(),
    );
  }
}
