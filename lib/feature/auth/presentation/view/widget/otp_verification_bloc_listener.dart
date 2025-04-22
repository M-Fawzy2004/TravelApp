import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:travel_app/core/helper/app_router.dart';
import 'package:travel_app/core/utils/top_snakbar_app.dart';
import 'package:travel_app/feature/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:travel_app/feature/auth/presentation/view/widget/otp_verification_view_body.dart';

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
          context.loaderOverlay.show();
        } else {
          context.loaderOverlay.hide();
        }

        if (state is AuthAuthenticated) {
          if (state.user.firstName == null || state.user.firstName!.isEmpty) {
            // User needs to complete profile
            context.push(AppRouter.userProfile);
          } else {
            // User has a complete profile

            showCustomTopSnackBar(
              context: context,
              message: 'تم التسجيل بنجاح',
            );
            context.go(AppRouter.mainView);
          }
        } else if (state is AuthError) {
          showCustomTopSnackBar(
            context: context,
            message: 'برجاء إعاده إدخال رمز التحقق الصالح',
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
