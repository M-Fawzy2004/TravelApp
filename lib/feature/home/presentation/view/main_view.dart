// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/core/helper/get_user.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:travel_app/feature/home/presentation/view/home_view.dart';
import 'package:travel_app/feature/resent_add/presentation/view/resently_added_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int screenIndex = 0;

  final List<Widget> screens = [
    HomeView(),
    ResentlyAddedView(),
    Center(
      child: Text("الرسائل"),
    ),
    Custom(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: screenIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.grey,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6,
              spreadRadius: 0,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: screenIndex,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          iconSize: 17.sp,
          selectedIconTheme: IconThemeData(size: 20.sp),
          selectedFontSize: 14.sp,
          unselectedFontSize: 12.sp,
          backgroundColor: Colors.transparent,
          selectedItemColor: AppColors.black,
          unselectedItemColor: Colors.black45,
          onTap: (index) {
            HapticFeedback.lightImpact();
            setState(() {
              screenIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.home),
              label: 'الرئيسيه',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.car),
              label: 'المضاف مؤخرا',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.facebookMessenger),
              label: 'الرسائل',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.user),
              label: 'الملف الشخصي',
            ),
          ],
        ),
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = getUser()?.firstName;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('مرحبا $user', style: Styles.font20ExtraBlackBold),
          Text('تسجيل الخروج ', style: Styles.font20ExtraBlackBold),
          IconButton(
            onPressed: () {
              context.read<AuthCubit>().signOut();
            },
            icon: Icon(FontAwesomeIcons.rightFromBracket),
          ),
        ],
      ),
    );
  }
}

class Custom extends StatelessWidget {
  const Custom({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          context.pushReplacement('/');
        }
      },
      child: NewWidget(),
    );
  }
}
