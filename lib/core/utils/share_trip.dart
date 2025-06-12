// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/utils/top_snakbar_app.dart';
import 'package:travel_app/core/widget/custom_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

void shareTrip(BuildContext context, {String? tripDetails}) {
  final String shareText =
      tripDetails ?? 'تفاصيل رحلتي الرائعة! 🌟\n\n[تفاصيل الرحلة هنا]';

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => Container(
      decoration: BoxDecoration(
        color: AppColors.getBackgroundColor(context),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      padding: EdgeInsets.all(20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.share,
            color: Colors.blue,
            size: 50.sp,
          ),
          heightBox(15),
          Text(
            'مشاركة تفاصيل الرحلة',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          heightBox(8),
          Text(
            'اختر التطبيق المناسب للمشاركة:',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[600],
            ),
          ),
          heightBox(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildAppButton(
                onTap: () => _shareToWhatsApp(shareText, context),
                context: context,
                icon: FontAwesomeIcons.whatsapp,
                label: 'واتساب',
                color: const Color(0xFF25D366),
              ),
              _buildAppButton(
                onTap: () => _shareToFacebook(shareText, context),
                context: context,
                icon: FontAwesomeIcons.facebook,
                label: 'فيسبوك',
                color: const Color(0xFF1877F2),
              ),
              _buildAppButton(
                onTap: () => _shareToInstagram(shareText, context),
                context: context,
                icon: FontAwesomeIcons.instagram,
                label: 'انستجرام',
                color: const Color(0xFFE4405F),
              ),
              _buildAppButton(
                onTap: () => _shareToX(shareText, context),
                context: context,
                icon: FontAwesomeIcons.x,
                label: 'X',
                color: Colors.black,
              ),
              _buildAppButton(
                onTap: () => _shareMore(shareText),
                context: context,
                icon: FontAwesomeIcons.ellipsis,
                label: 'المزيد',
                color: Colors.red,
              ),
            ],
          ),
          heightBox(20),
          CustomButton(
            buttonText: 'إلغاء',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ),
  );
}

void _shareToWhatsApp(String text, BuildContext context) async {
  try {
    await Clipboard.setData(ClipboardData(text: text));
    final encodedText = Uri.encodeComponent(text);
    final String whatsappWebUrl = 'https://wa.me/?text=$encodedText';
    if (await canLaunchUrl(Uri.parse(whatsappWebUrl))) {
      await launchUrl(
        Uri.parse(whatsappWebUrl),
        mode: LaunchMode.externalApplication,
      );
      Navigator.pop(context);
      Future.delayed(const Duration(milliseconds: 100), () {
        showCustomTopSnackBar(
          context: context,
          message: 'تم نسخ النص وفتح واتساب أو المتصفح',
        );
      });
    } else {
      Navigator.pop(context);
      Future.delayed(const Duration(milliseconds: 100), () {
        showCustomTopSnackBar(
          context: context,
          message: 'تطبيق واتساب غير مثبت على الجهاز',
        );
      });
    }
  } catch (e) {
    Navigator.pop(context);
    Future.delayed(const Duration(milliseconds: 100), () {
      showCustomTopSnackBar(
        context: context,
        message: 'حدث خطأ أثناء محاولة فتح واتساب',
      );
    });
  }
}

void _shareToFacebook(String text, BuildContext context) async {
  final String encodedText = Uri.encodeComponent(text);

  try {
    const String facebookAppUrl = 'fb://';
    if (await canLaunchUrl(Uri.parse(facebookAppUrl))) {
      await launchUrl(
        Uri.parse(facebookAppUrl),
        mode: LaunchMode.externalApplication,
      );
    } else {
      final String webUrl =
          'https://www.facebook.com/sharer/sharer.php?u=https://example.com&quote=$encodedText';
      await launchUrl(
        Uri.parse(webUrl),
        mode: LaunchMode.externalApplication,
      );
    }
    Navigator.pop(context);
    Future.delayed(const Duration(milliseconds: 100), () {
      showCustomTopSnackBar(context: context, message: 'تم فتح فيسبوك');
    });
  } catch (e) {
    Navigator.pop(context);
    Future.delayed(const Duration(milliseconds: 100), () {
      showCustomTopSnackBar(
        context: context,
        message: 'حدث خطاء في فتح فيسبوك',
      );
    });
  }
}

void _shareToInstagram(String text, BuildContext context) async {
  try {
    const String instagramUrl = 'instagram://camera';
    if (await canLaunchUrl(Uri.parse(instagramUrl))) {
      await launchUrl(
        Uri.parse(instagramUrl),
        mode: LaunchMode.externalApplication,
      );
      Navigator.pop(context);
      Future.delayed(const Duration(milliseconds: 100), () {
        showCustomTopSnackBar(context: context, message: 'تم فتح انستجرام');
      });
    } else {
      Navigator.pop(context);
      Future.delayed(const Duration(milliseconds: 100), () {
        showCustomTopSnackBar(
            context: context, message: 'انستجرام غير مثبت على الجهاز');
      });
    }
  } catch (e) {
    Navigator.pop(context);
    Future.delayed(const Duration(milliseconds: 100), () {
      showCustomTopSnackBar(context: context, message: 'تعذر فتح انستجرام');
    });
  }
}

void _shareToX(String text, BuildContext context) async {
  final String encodedText = Uri.encodeComponent(text);

  try {
    final String twitterUrl = 'twitter://post?message=$encodedText';
    if (await canLaunchUrl(Uri.parse(twitterUrl))) {
      await launchUrl(
        Uri.parse(twitterUrl),
        mode: LaunchMode.externalApplication,
      );
    } else {
      final String webUrl =
          'https://twitter.com/intent/tweet?text=$encodedText';
      await launchUrl(
        Uri.parse(webUrl),
        mode: LaunchMode.externalApplication,
      );
    }
    Navigator.pop(context);
    Future.delayed(const Duration(milliseconds: 100), () {
      showCustomTopSnackBar(context: context, message: 'تم فتح X');
    });
  } catch (e) {
    Navigator.pop(context);
    Future.delayed(const Duration(milliseconds: 100), () {
      showCustomTopSnackBar(context: context, message: 'حدث خطاء في فتح X');
    });
  }
}

void _shareMore(String text) {
  Share.share(text);
}

Widget _buildAppButton({
  required IconData icon,
  required String label,
  required Color color,
  required BuildContext context,
  void Function()? onTap,
}) {
  return Column(
    children: [
      GestureDetector(
        onTap: onTap,
        child: Container(
          width: 50.w,
          height: 50.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.r),
            border: Border.all(color: color.withOpacity(0.7), width: 2.w),
          ),
          child: Icon(
            icon,
            color: color,
            size: 20.sp,
          ),
        ),
      ),
      heightBox(10),
      Text(
        label,
        style: Styles.font12GreyExtraBold(context),
      ),
    ],
  );
}
