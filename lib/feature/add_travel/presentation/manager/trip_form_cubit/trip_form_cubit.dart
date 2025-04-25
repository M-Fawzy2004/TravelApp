import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/services/auth_service.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/feature/add_travel/data/repos/trip_repo.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_form_cubit/trip_form_state.dart';

class TripFormCubit extends Cubit<TripFormState> {
  final TripRepository _tripRepository;
  final AuthService _authService;

  // بيانات المستخدم
  String _userId = '';
  String _userFirstName = '';
  String _userLastName = '';
  String _userPhone = '';
  bool _isUserDataLoaded = false;

  TripFormCubit({
    required TripRepository tripRepository,
    required AuthService authService,
  })  : _tripRepository = tripRepository,
        _authService = authService,
        super(const TripFormState()) {
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final currentUser = await _authService.getCurrentUser();
      if (currentUser != null) {
        _userId = currentUser.id;

        final userData = await _authService.getUserData(_userId);
        if (userData != null) {
          _userFirstName = userData['firstName'] ?? '';
          _userLastName = userData['lastName'] ?? '';
          _userPhone = userData['phone'] ?? '';
        } else {
          _userFirstName = currentUser.firstName ?? '';
          _userLastName = currentUser.lastName ?? '';
          _userPhone = currentUser.phoneNumber;
        }
        _isUserDataLoaded = true;
      }
    } catch (e) {
      emit(state.copyWith(
        error: 'حدث خطأ في تحميل بيانات المستخدم: ${e.toString()}',
      ));
    }
  }

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

  // انتظار تحميل بيانات المستخدم إذا لم تكن جاهزة
  Future<void> _ensureUserDataLoaded() async {
    if (!_isUserDataLoaded) {
      // انتظار حتى يتم تحميل بيانات المستخدم
      await _loadUserData();

      // التحقق مرة أخرى بعد المحاولة
      if (!_isUserDataLoaded) {
        throw Exception('لم يتم تحميل بيانات المستخدم بنجاح');
      }
    }
  }

  // تعديل دالة تقديم النموذج لضمان تحميل بيانات المستخدم أولاً
  Future<void> submitForm() async {
    if (!validateForm()) {
      emit(state.copyWith(
        error: 'يرجى تصحيح الأخطاء قبل الإرسال',
      ));
      return;
    }

    try {
      emit(state.copyWith(isSubmitting: true, error: null));

      // التأكد من تحميل بيانات المستخدم قبل إنشاء الرحلة
      await _ensureUserDataLoaded();

      // إنشاء نموذج الرحلة مع بيانات المستخدم
      final tripModel = TripModel(
        id: '',
        creatorId: _userId,
        creatorFirstName: _userFirstName,
        creatorLastName: _userLastName,
        creatorPhone: _userPhone,
        tripType: state.tripType,
        destinationName: state.destinationName,
        departureLocation: state.departureLocation,
        arrivalLocation: state.arrivalLocation,
        availableSeats: state.availableSeats,
        tripDate: state.tripDate ?? DateTime.now(),
        tripTime: state.tripTime ?? const TimeOfDay(hour: 12, minute: 0),
        duration: state.duration,
        price: state.price,
        additionalDetails: state.additionalDetails,
        gradientIndex: state.gradientIndex,
      );

      final result = await _tripRepository.createTrip(tripModel);

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

  // تعديل دالة تحديث رحلة موجودة لضمان تحميل بيانات المستخدم أولاً
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

      // التأكد من تحميل بيانات المستخدم قبل تحديث الرحلة
      await _ensureUserDataLoaded();

      // إنشاء نموذج الرحلة مع بيانات المستخدم
      final tripModel = TripModel(
        id: id,
        creatorId: _userId,
        creatorFirstName: _userFirstName,
        creatorLastName: _userLastName,
        creatorPhone: _userPhone,
        tripType: state.tripType,
        destinationName: state.destinationName,
        departureLocation: state.departureLocation,
        arrivalLocation: state.arrivalLocation,
        availableSeats: state.availableSeats,
        tripDate: state.tripDate ?? DateTime.now(),
        tripTime: state.tripTime ?? const TimeOfDay(hour: 12, minute: 0),
        duration: state.duration,
        price: state.price,
        additionalDetails: state.additionalDetails,
        gradientIndex: state.gradientIndex,
      );

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
        gradientIndex: trip.gradientIndex,
      ),
    );
  }
}
