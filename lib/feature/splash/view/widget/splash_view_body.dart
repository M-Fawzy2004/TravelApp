import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/core/helper/app_router.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  final String word = 'RIHLA';
  List<int> visibleIndices = [];
  bool animationComplete = false;

  @override
  void initState() {
    super.initState();
    animateLetters();
  }

  void animateLetters() {
    for (int i = 0; i < word.length; i++) {
      Future.delayed(Duration(milliseconds: i * 300), () {
        setState(() {
          visibleIndices.add(i);
        });

        if (i == word.length - 1) {
          Future.delayed(const Duration(milliseconds: 600), () {
            setState(() {
              animationComplete = true;
            });

            Future.delayed(const Duration(milliseconds: 600), () {
              // ignore: use_build_context_synchronously
              context.pushReplacement(AppRouter.onboardingView);
            });
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(word.length, (index) {
                  final isVisible = visibleIndices.contains(index);
                  return TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: isVisible ? 1 : 0),
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOutBack,
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value.clamp(0.0, 1.0),
                        child: Transform.translate(
                          offset: Offset(-50 * (1 - value), 0),
                          child: Transform.scale(
                            scale: value,
                            child: child,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      word[index],
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 90.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }),
              ),
            ),
            if (animationComplete)
              AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(milliseconds: 500),
                child: Text(
                  'DEV. Mohamed Fawzy',
                  style: Styles.font14GreyExtraBold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
