import 'package:flutter/material.dart';
import 'package:travel_app/feature/home/presentation/view/captain_delivery_directory/presentation/view/widget/captain_delivery_directory_view_body.dart';

class CaptainDeliveryDirectoryView extends StatelessWidget {
  const CaptainDeliveryDirectoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: CaptainDeliveryDirectoryViewBody(),
      ),
    );
  }
}
