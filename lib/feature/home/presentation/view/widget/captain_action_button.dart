import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';

class CaptainActionButton extends StatefulWidget {
  const CaptainActionButton({super.key});

  @override
  State<CaptainActionButton> createState() => _CaptainActionButtonState();
}

class _CaptainActionButtonState extends State<CaptainActionButton> {
  String tripStatus = "جار التجهيز";
  bool _isTripStarted = false;
  bool _isTripEnded = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _isTripEnded
                ? null
                : () {
                    setState(() {
                      if (!_isTripStarted) {
                        _isTripStarted = true;
                        tripStatus = "في الطريق";
                      } else {
                        _isTripEnded = true;
                        tripStatus = "مكتمل";
                      }
                    });
                  },
            icon: Icon(
              _isTripStarted ? Icons.check_circle : Icons.play_arrow,
              color: Colors.white,
            ),
            label: Text(
              _isTripStarted ? 'إنهاء الرحلة' : 'بدء الرحلة',
              style: const TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: _isTripStarted ? Colors.green : Colors.blue,
              padding: EdgeInsets.symmetric(vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        if (_isTripStarted && !_isTripEnded) ...[
          widthBox(12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // Show dialog to contact passenger
                showDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: const Text('الاتصال بالراكب'),
                    content: const Text('هل تريد الاتصال بالراكب؟'),
                    actions: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Text(
                          'إلغاء',
                          style: Styles.font14GreyExtraBold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // Contact passenger logic here
                          Navigator.pop(context);
                        },
                        icon: Text(
                          'اتصال',
                          style: Styles.font14GreyExtraBold,
                        ),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.phone, color: Colors.white),
              label: const Text(
                'اتصال بالراكب',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
