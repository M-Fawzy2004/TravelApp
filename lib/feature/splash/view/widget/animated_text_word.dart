import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';

class AnimatedTextWord extends StatelessWidget {
  final String word;
  final List<int> visibleIndices;

  const AnimatedTextWord({
    super.key,
    required this.word,
    required this.visibleIndices,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(word.length, (index) {
          final isVisible = visibleIndices.contains(index);
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 600),
            switchInCurve: Curves.easeOutBack,
            child: isVisible
                ? TweenAnimationBuilder<double>(
                    key: ValueKey(index),
                    tween: Tween(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 600),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(-30 * (1 - value), 0),
                          child: Transform.scale(
                            scale: 0.5 + 0.5 * value,
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
                  )
                : const SizedBox.shrink(),
          );
        }),
      ),
    );
  }
}
