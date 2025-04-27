import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/widget/custom_button.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_cubit/trip_cubit.dart';
import 'package:travel_app/feature/add_travel/presentation/view/edit_travel_view.dart';

class TripsForm extends StatefulWidget {
  const TripsForm({
    super.key,
    required this.trip,
  });

  final TripModel trip;

  @override
  State<TripsForm> createState() => _TripsFormState();
}

class _TripsFormState extends State<TripsForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.r),
          topRight: Radius.circular(25.r),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              backgroundColor: AppColors.primaryColor,
              buttonText: 'تعديل الرحله',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditTravelView(trip: widget.trip),
                  ),
                );
              },
            ),
          ),
          widthBox(10),
          Expanded(
            child: CustomButton(
              backgroundColor: Colors.red,
              buttonText: 'حذف الرحله',
              onPressed: () async {
                _showDeleteConfirmationDialog(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    // Store the context that has access to TripCubit
    final tripCubit = context.read<TripCubit>();

    showCupertinoDialog(
      context: context,
      builder: (dialogContext) => CupertinoAlertDialog(
        title: Center(
          child: Text(
            'تأكيد الحذف',
            style: Styles.font20ExtraBlackBold,
          ),
        ),
        content: Text(
          'هل أنت متأكد من رغبتك في حذف هذه الرحلة؟',
          style: Styles.font14DarkGreyBold,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
            child: Text(
              'إلغاء',
              style: Styles.font16BlackBold,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              // Use the stored reference instead of context.watch
              tripCubit.deleteTrip(widget.trip.id);
            },
            child: Text(
              'حذف',
              style: Styles.font16BlackBold.copyWith(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
