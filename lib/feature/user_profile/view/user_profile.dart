import 'package:flutter/material.dart';
import 'package:travel_app/feature/user_profile/view/widget/user_profile_bloc_listener.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: UserPofileBlocListener(),
        ),
      ),
    );
  }
}
