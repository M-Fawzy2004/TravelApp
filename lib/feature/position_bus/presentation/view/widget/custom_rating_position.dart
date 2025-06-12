// custom_rating_position.dart - Updated Version
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';

class CustomRatingPosition extends StatefulWidget {
  final double initialRating;
  final Function(double) onRatingUpdate;

  const CustomRatingPosition({
    super.key,
    this.initialRating = 3.0,
    required this.onRatingUpdate,
  });

  @override
  State<CustomRatingPosition> createState() => _CustomRatingPositionState();
}

class _CustomRatingPositionState extends State<CustomRatingPosition> {
  late double currentRating;

  @override
  void initState() {
    super.initState();
    currentRating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RatingBar.builder(
          initialRating: currentRating,
          itemCount: 5,
          itemSize: 35.sp,
          allowHalfRating: false,
          glow: true,
          glowColor: Colors.amber.withOpacity(0.3),
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return const Icon(
                  Icons.sentiment_very_dissatisfied,
                  color: Colors.red,
                );
              case 1:
                return const Icon(
                  Icons.sentiment_dissatisfied,
                  color: Colors.redAccent,
                );
              case 2:
                return const Icon(
                  Icons.sentiment_neutral,
                  color: Colors.amber,
                );
              case 3:
                return const Icon(
                  Icons.sentiment_satisfied,
                  color: Colors.lightGreen,
                );
              case 4:
                return const Icon(
                  Icons.sentiment_very_satisfied,
                  color: Colors.green,
                );
              default:
                return Container();
            }
          },
          onRatingUpdate: (rating) {
            setState(() {
              currentRating = rating;
            });
            widget.onRatingUpdate(rating);
          },
        ),
        heightBox(8),
        Text(
          _getRatingText(currentRating),
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: _getRatingColor(currentRating),
          ),
        ),
      ],
    );
  }

  String _getRatingText(double rating) {
    switch (rating.round()) {
      case 1:
        return 'غير راضي جداً';
      case 2:
        return 'غير راضي';
      case 3:
        return 'مقبول';
      case 4:
        return 'راضي';
      case 5:
        return 'ممتاز';
      default:
        return 'مقبول';
    }
  }

  Color _getRatingColor(double rating) {
    switch (rating.round()) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.redAccent;
      case 3:
        return Colors.amber;
      case 4:
        return Colors.lightGreen;
      case 5:
        return Colors.green;
      default:
        return Colors.amber;
    }
  }
}
