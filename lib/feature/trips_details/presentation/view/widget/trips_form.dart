import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
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
    return Column(
      children: [
        CustomButton(
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
        heightBox(10),
        CustomButton(
          backgroundColor: Colors.red,
          buttonText: 'حذف الرحله',
          onPressed: () async {
            _showDeleteConfirmationDialog(context);
          },
        ),
      ],
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تأكيد الحذف'),
        content: const Text('هل أنت متأكد من رغبتك في حذف هذه الرحلة؟'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<TripCubit>().deleteTrip(widget.trip.id);
            },
            child: const Text(
              'حذف',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
