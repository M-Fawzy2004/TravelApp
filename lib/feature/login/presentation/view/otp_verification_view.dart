import 'package:flutter/material.dart';
import 'package:travel_app/feature/login/presentation/view/widget/otp_verification_bloc_listener.dart';

class OtpVerificationView extends StatelessWidget {
  const OtpVerificationView({super.key, required this.verificationId});
  final String verificationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OtpVerificationBlocListener(
        verificationId: verificationId,
      ),
    );
  }
}
