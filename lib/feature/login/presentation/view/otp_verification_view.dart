import 'package:flutter/material.dart';
import 'package:travel_app/feature/login/presentation/view/widget/otp_verification_view_body.dart';

class OtpVerificationView extends StatelessWidget {
  const OtpVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OtpVerificationViewBody(),
    );
  }
}
