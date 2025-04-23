import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/feature/add_travel/data/repos/trip_repo.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_form_cubit/trip_form_state.dart';

class TripFormCubit extends Cubit<TripFormState> {
  final TripRepository _tripRepository;

  TripFormCubit({required TripRepository tripRepository})
      : _tripRepository = tripRepository,
        super(const TripFormState());

  void setTripType(TripType tripType) {
    emit(state.copyWith(tripType: tripType));
  }

  void setDestinationName(String destinationName) {
    final fieldErrors = Map<String, String>.from(state.fieldErrors);

    if (destinationName.isEmpty) {
      fieldErrors['destinationName'] = 'يرجى إدخال اسم الوجهة';
    } else {
      fieldErrors.remove('destinationName');
    }

    emit(state.copyWith(
      destinationName: destinationName,
      fieldErrors: fieldErrors,
    ));
  }

  void setDepartureLocation(String departureLocation) {
    final fieldErrors = Map<String, String>.from(state.fieldErrors);

    if (departureLocation.isEmpty) {
      fieldErrors['departureLocation'] = 'يرجى إدخال مكان الانطلاق';
    } else {
      fieldErrors.remove('departureLocation');
    }

    emit(state.copyWith(
      departureLocation: departureLocation,
      fieldErrors: fieldErrors,
    ));
  }

  void setArrivalLocation(String arrivalLocation) {
    final fieldErrors = Map<String, String>.from(state.fieldErrors);

    if (arrivalLocation.isEmpty) {
      fieldErrors['arrivalLocation'] = 'يرجى إدخال مكان الوصول';
    } else {
      fieldErrors.remove('arrivalLocation');
    }

    emit(state.copyWith(
      arrivalLocation: arrivalLocation,
      fieldErrors: fieldErrors,
    ));
  }

  void setAvailableSeats(int availableSeats) {
    final fieldErrors = Map<String, String>.from(state.fieldErrors);

    if (availableSeats < 0) {
      fieldErrors['availableSeats'] = 'عدد المقاعد لا يمكن أن يكون سالباً';
    } else {
      fieldErrors.remove('availableSeats');
    }

    emit(state.copyWith(
      availableSeats: availableSeats,
      fieldErrors: fieldErrors,
    ));
  }

  void setTripDate(DateTime tripDate) {
    final fieldErrors = Map<String, String>.from(state.fieldErrors);
    fieldErrors.remove('tripDate');

    emit(state.copyWith(
      tripDate: tripDate,
      fieldErrors: fieldErrors,
    ));
  }

  void setTripTime(TimeOfDay tripTime) {
    final fieldErrors = Map<String, String>.from(state.fieldErrors);
    fieldErrors.remove('tripTime');

    emit(state.copyWith(
      tripTime: tripTime,
      fieldErrors: fieldErrors,
    ));
  }

  void setDuration(String duration) {
    emit(state.copyWith(duration: duration));
  }

  void setPrice(double price) {
    final fieldErrors = Map<String, String>.from(state.fieldErrors);

    if (price < 0) {
      fieldErrors['price'] = 'السعر لا يمكن أن يكون سالباً';
    } else {
      fieldErrors.remove('price');
    }

    emit(state.copyWith(
      price: price,
      fieldErrors: fieldErrors,
    ));
  }

  void setAdditionalDetails(String additionalDetails) {
    emit(state.copyWith(additionalDetails: additionalDetails));
  }

  void setGradientIndex(int index) {
    emit(state.copyWith(gradientIndex: index));
  }

  bool validateForm() {
    final fieldErrors = <String, String>{};

    if (state.destinationName.isEmpty) {
      fieldErrors['destinationName'] = 'يرجى إدخال اسم الوجهة';
    }

    if (state.departureLocation.isEmpty) {
      fieldErrors['departureLocation'] = 'يرجى إدخال مكان الانطلاق';
    }

    if (state.arrivalLocation.isEmpty) {
      fieldErrors['arrivalLocation'] = 'يرجى إدخال مكان الوصول';
    }

    if (state.tripDate == null) {
      fieldErrors['tripDate'] = 'يرجى تحديد تاريخ الرحلة';
    }

    if (state.tripTime == null) {
      fieldErrors['tripTime'] = 'يرجى تحديد وقت الرحلة';
    }

    if (state.availableSeats < 0) {
      fieldErrors['availableSeats'] = 'عدد المقاعد لا يمكن أن يكون سالباً';
    }

    if (state.price < 0) {
      fieldErrors['price'] = 'السعر لا يمكن أن يكون سالباً';
    }

    emit(state.copyWith(fieldErrors: fieldErrors));

    return fieldErrors.isEmpty;
  }

  Future<void> submitForm() async {
    if (!validateForm()) {
      emit(state.copyWith(
        error: 'يرجى تصحيح الأخطاء قبل الإرسال',
      ));
      return;
    }

    try {
      emit(state.copyWith(isSubmitting: true, error: null));

      final result = await _tripRepository.createTrip(state.toTripModel());

      result.fold((failure) {
        emit(state.copyWith(
          isSubmitting: false,
          error: failure.message,
        ));
      }, (_) {
        emit(const TripFormState());
      });
    } catch (e) {
      emit(state.copyWith(
        isSubmitting: false,
        error: 'حدث خطأ غير متوقع: ${e.toString()}',
      ));
    }
  }

  void resetForm() {
    emit(const TripFormState());
  }

  void loadTripForEdit(TripModel trip) {
    emit(
      TripFormState(
        tripType: trip.tripType,
        destinationName: trip.destinationName,
        departureLocation: trip.departureLocation,
        arrivalLocation: trip.arrivalLocation,
        availableSeats: trip.availableSeats,
        tripDate: trip.tripDate,
        tripTime: trip.tripTime,
        duration: trip.duration,
        price: trip.price,
        additionalDetails: trip.additionalDetails,
      ),
    );
  }

  Future<void> updateExistingTrip(String id) async {
    if (!validateForm()) {
      emit(
        state.copyWith(
          error: 'يرجى تصحيح الأخطاء قبل الإرسال',
        ),
      );
      return;
    }

    try {
      emit(state.copyWith(isSubmitting: true, error: null));

      final tripModel = state.toTripModel().copyWith(id: id);

      final result = await _tripRepository.updateTrip(tripModel);

      result.fold(
        (failure) {
          emit(
            state.copyWith(
              isSubmitting: false,
              error: failure.message,
            ),
          );
        },
        (_) {
          emit(const TripFormState());
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          isSubmitting: false,
          error: 'حدث خطأ غير متوقع: ${e.toString()}',
        ),
      );
    }
  }
}
