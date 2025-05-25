import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/core/helper/app_router.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/splash/view/widget/animated_text_word.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedTextWord(
              word: word,
              visibleIndices: visibleIndices,
            ),
            if (animationComplete)
              AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(milliseconds: 600),
                child: Text(
                  'DEV. Mohamed Fawzy',
                  style: Styles.font14GreyExtraBold(context),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void animateLetters() {
    for (int i = 0; i < word.length; i++) {
      Future.delayed(Duration(milliseconds: i * 300), () {
        setState(() {
          visibleIndices.add(i);
        });

        if (i == word.length - 1) {
          Future.delayed(
            const Duration(milliseconds: 600),
            () {
              setState(() {
                animationComplete = true;
              });

              Future.delayed(
                const Duration(seconds: 1),
                () {
                  // ignore: use_build_context_synchronously
                  context.pushReplacement(AppRouter.onboardingView);
                },
              );
            },
          );
        }
      });
    }
  }
}
