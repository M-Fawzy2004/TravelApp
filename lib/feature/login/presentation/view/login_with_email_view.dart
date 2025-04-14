import 'package:flutter/material.dart';
import 'package:travel_app/feature/login/presentation/view/widget/login_with_view_body.dart';

class LoginWithEmailView extends StatelessWidget {
  const LoginWithEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginWithEmailViewBody(),
    );
  }
}
