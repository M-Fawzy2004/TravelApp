import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:travel_app/core/helper/app_router.dart';
import 'package:travel_app/core/utils/app_flush_bar.dart';
import 'package:travel_app/feature/login/presentation/manager/cubit/auth_cubit.dart';
import 'package:travel_app/feature/login/presentation/view/widget/otp_verification_view_body.dart';

class OtpVerificationBlocListener extends StatefulWidget {
  const OtpVerificationBlocListener({
    super.key,
    required this.verificationId,
  });

  final String verificationId;

  @override
  State<OtpVerificationBlocListener> createState() =>
      _OtpVerificationBlocListenerState();
}

class _OtpVerificationBlocListenerState
    extends State<OtpVerificationBlocListener> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          setState(() {
            isLoading = true;
          });
          context.loaderOverlay.show();
        } else {
          context.loaderOverlay.hide();
          setState(() {
            isLoading = false;
          });
        }
        
        if (state is AuthAuthenticated) {
          CustomFlushBar.showMessage(
            context: context,
            message: "تم التحقق بنجاح",
          );
          
          if (state.user.firstName == null || state.user.firstName!.isEmpty) {
            // User needs to complete profile
            context.push(AppRouter.userProfile);
          } else {
            // User has a complete profile
            context.go(AppRouter.homeView);
          }
        } else if (state is AuthError) {
          CustomFlushBar.showMessage(
            context: context,
            message: state.message,
          );
        }
      },
      child: OtpVerificationViewBody(
        verificationId: widget.verificationId,
        isLoading: isLoading,
      ),
    );
  }
}