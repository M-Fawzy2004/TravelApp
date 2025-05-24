import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/utils/form_controller.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/utils/tripe_type.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_form_cubit/trip_form_cubit.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/add_travel_bloc_consumer.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/custom_loaction_field.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/date_time_picker.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/destination_field.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/details_field.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/duration_price_field.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/seats_field.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/submit_custom_button.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/travel_type_selector.dart';

class EditTravelForm extends StatefulWidget {
  final TripModel trip;

  const EditTravelForm({
    super.key,
    required this.trip,
  });

  @override
  State<EditTravelForm> createState() => _EditTravelFormState();
}

class _EditTravelFormState extends State<EditTravelForm> {
  final _formControllers = FormControllers();
  late String _selectedType;

  final List<String> _travelTypes = [
    'رحلة خاصة',
    'شحن أغراض',
  ];

  @override
  void initState() {
    super.initState();
    _loadTripData();
  }

  void _loadTripData() {
    final tripFormCubit = context.read<TripFormCubit>();
    tripFormCubit.loadTripForEdit(widget.trip);

    // Set selected type based on trip type
    switch (widget.trip.tripType) {
      case TripType.specialTrip:
        _selectedType = 'رحلة خاصة';
        break;
      case TripType.cargoShipping:
        _selectedType = 'شحن أغراض';
        break;
    }
  }

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
              heightBox(10),
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
              heightBox(10),
              DestinationField(
                errorText: state.fieldErrors['destinationName'],
                initialValue: widget.trip.destinationName,
              ),
              heightBox(10),
              CustomLoactionField(
                errorTextStartLocation: state.fieldErrors['departureLocation'],
                errorTextEndLocation: state.fieldErrors['arrivalLocation'],
                initialStartLocation: widget.trip.departureLocation,
                initialEndLocation: widget.trip.arrivalLocation,
              ),
              heightBox(10),
              SeatsField(
                errorText: state.fieldErrors['availableSeats'],
                initialValue: widget.trip.availableSeats.toString(),
              ),
              heightBox(10),
              DateTimePicker(
                selectedDate: state.tripDate ?? widget.trip.tripDate,
                selectedTime: state.tripTime ?? widget.trip.tripTime,
                dateErrorText: state.fieldErrors['tripDate'],
                timeErrorText: state.fieldErrors['tripTime'],
              ),
              heightBox(10),
              DurationPriceField(
                errorTextPrice: state.fieldErrors['price'],
                initialDuration: widget.trip.duration,
                initialPrice: widget.trip.price.toString(),
              ),
              heightBox(10),
              DetailsField(
                initialValue: widget.trip.additionalDetails,
              ),
              heightBox(20),
              SubmitCustomButton(
                onPressed: state.isSubmitting
                    ? null
                    : () {
                        context
                            .read<TripFormCubit>()
                            .updateExistingTrip(widget.trip.id);
                      },
                buttonText: state.isSubmitting
                    ? 'جاري التحديث...'
                    : 'تحديث $_selectedType',
              ),
            ],
          ),
        );
      },
    );
  }
}
