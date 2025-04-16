// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/core/helper/app_router.dart';
import 'package:travel_app/core/services/auth_service.dart';
import 'package:travel_app/feature/home/presentation/view/widget/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = GetIt.instance<AuthService>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            await authService.signOut();
            context.go(AppRouter.loginView);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: HomeViewBody(),
    );
  }
}
