import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/core/helper/app_router.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/auth/presentation/manager/cubit/auth_cubit.dart';

void showLogoutConfirmationDialog(BuildContext context) {
  showCupertinoDialog(
    context: context,
    builder: (dialogContext) => CupertinoAlertDialog(
      title: Center(
        child: Text(
          'تأكيد الخروج',
          style: Styles.font20ExtraBlackBold(context),
        ),
      ),
      content: Text(
        'هل أنت متأكد أنك تريد تسجيل الخروج؟',
        style: Styles.font14DarkGreyBold(context),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(dialogContext).pop();
          },
          child: Text(
            'إلغاء',
            style: Styles.font16BlackBold(context),
          ),
        ),
        TextButton(
          onPressed: () async {
            Navigator.of(dialogContext).pop();
            await context.read<AuthCubit>().signOut();
            if (context.mounted) {
              context.pushReplacement(AppRouter.loginView);
            }
          },
          child: Text(
            'تسجيل الخروج',
            style: Styles.font16BlackBold(context).copyWith(
              color: Colors.red,
            ),
          ),
        ),
      ],
    ),
  );
}
