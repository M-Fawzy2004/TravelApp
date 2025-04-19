import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:travel_app/core/helper/app_router.dart';
import 'package:travel_app/core/utils/app_flush_bar.dart';
import 'package:travel_app/feature/login/presentation/manager/cubit/auth_cubit.dart';
import 'package:travel_app/feature/user_profile/view/widget/user_profile_body.dart';

class UserPofileBlocListener extends StatefulWidget {
  const UserPofileBlocListener({
    super.key,
  });

  @override
  State<UserPofileBlocListener> createState() => _UserPofileBlocListenerState();
}

class _UserPofileBlocListenerState extends State<UserPofileBlocListener> {
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

        if (state is AuthSaved) {
          CustomFlushBar.showMessage(
            context,
            "تم حفظ البيانات بنجاح",
          );
        } else if (state is AuthCodeSent) {
          context.push(AppRouter.otpVerf, extra: state.user.id);
        } else if (state is AuthAuthenticated) {
          if (state.user.firstName != null &&
              state.user.firstName!.isNotEmpty) {
            context.go(AppRouter.mainView);
          }
        } else if (state is AuthError) {
          CustomFlushBar.showMessage(
            context,
            state.message,
          );
        }
      },
      child: UserProfileBody(),
    );
  }
}
