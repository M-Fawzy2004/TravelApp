import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:travel_app/core/helper/app_router.dart';
import 'package:travel_app/core/utils/top_snakbar_app.dart';
import 'package:travel_app/feature/login/presentation/manager/cubit/auth_cubit.dart';
import 'package:travel_app/feature/login/presentation/view/widget/login_form.dart';

class LoginFormBlocListener extends StatefulWidget {
  const LoginFormBlocListener({super.key});

  @override
  State<LoginFormBlocListener> createState() => _LoginFormBlocListenerState();
}

class _LoginFormBlocListenerState extends State<LoginFormBlocListener> {
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

        if (state is AuthCodeSent) {
          context.push(AppRouter.otpVerf, extra: state.user.id);
        } else if (state is AuthAuthenticated) {
          if (state.user.firstName == null || state.user.firstName!.isEmpty) {
            context.go(AppRouter.userProfile);
          } else {
            context.go(AppRouter.mainView);
          }
        } else if (state is AuthError) {
          showCustomTopSnackBar(
            context: context,
            message: 'حدث خطاء في التسجيل',
          );
        }
      },
      child: LoginForm(isLoading: isLoading),
    );
  }
}
