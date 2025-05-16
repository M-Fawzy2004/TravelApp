// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/utils/form_controller.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/utils/tripe_type.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_form_cubit/trip_form_cubit.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/add_travel_bloc_consumer.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/custom_loaction_field.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/date_time_picker.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/destination_field.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/details_field.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/duration_price_field.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/gredient_selector_row.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/seats_field.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/submit_custom_button.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/travel_type_selector.dart';

class AddTravelForm extends StatefulWidget {
  const AddTravelForm({super.key});

  @override
  State<AddTravelForm> createState() => _AddTravelFormState();
}

class _AddTravelFormState extends State<AddTravelForm> {
  final _formControllers = FormControllers();
  String _selectedType = 'رحلة خاصة';

  final List<String> _travelTypes = [
    'رحلة خاصة',
    'شحن أغراض',
  ];

  @override
  void dispose() {
    _formControllers.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AddTravelBlocConsumer(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            children: [
              const GradientSelectorRow(),
              heightBox(15),
              TravelTypeSelector(
                selectedType: _selectedType,
                travelTypes: _travelTypes,
                onChanged: (newType) {
                  setState(
                    () {
                      _selectedType = newType;
                    },
                  );
                  context.read<TripFormCubit>().setTripType(
                        mapStringToTripType(newType),
                      );
                },
              ),
              heightBox(15),
              DestinationField(
                errorText: state.fieldErrors['destinationName'],
              ),
              heightBox(15),
              CustomLoactionField(
                errorTextStartLocation: state.fieldErrors['departureLocation'],
                errorTextEndLocation: state.fieldErrors['arrivalLocation'],
              ),
              heightBox(15),
              DateTimePicker(
                selectedDate: state.tripDate,
                selectedTime: state.tripTime,
                dateErrorText: state.fieldErrors['tripDate'],
                timeErrorText: state.fieldErrors['tripTime'],
              ),
              heightBox(15),
              DurationPriceField(
                errorTextPrice: state.fieldErrors['price'],
              ),
              heightBox(15),
              SeatsField(
                errorText: state.fieldErrors['availableSeats'],
              ),
              heightBox(15),
              const DetailsField(),
              heightBox(20),
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: SubmitCustomButton(
                  onPressed: state.isSubmitting
                      ? null
                      : () {
                          context.read<TripFormCubit>().submitForm();
                        },
                  buttonText: state.isSubmitting
                      ? 'جاري الإضافه...'
                      : 'إضافه $_selectedType',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
