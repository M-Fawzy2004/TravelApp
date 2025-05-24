// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/services/auth_service.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/feature/add_travel/data/repos/trip_repo.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_form_cubit/trip_form_state.dart';

class TripFormCubit extends Cubit<TripFormState> {
  final TripRepository _tripRepository;
  final AuthService _authService;

  String _userId = '';
  String _userFirstName = '';
  String _userLastName = '';
  String _userPhone = '';
  bool _isUserDataLoaded = false;
  bool _isDisposed = false;

  TripFormCubit({
    required TripRepository tripRepository,
    required AuthService authService,
  })  : _tripRepository = tripRepository,
        _authService = authService,
        super(const TripFormState()) {
    _loadUserData();
  }

  @override
  Future<void> close() {
    _isDisposed = true;
    return super.close();
  }

  Future<void> _loadUserData() async {
    if (_isDisposed) return;

    try {
      final currentUser = await _authService.getCurrentUser();
      if (currentUser != null && !_isDisposed) {
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
      if (!_isDisposed) {
        emit(state.copyWith(
          error: 'حدث خطأ في تحميل بيانات المستخدم: ${e.toString()}',
        ));
      }
    }
  }

  void setTripType(TripType tripType) {
    if (_isDisposed) return;
    emit(state.copyWith(tripType: tripType));
  }

  void setDestinationName(String destinationName) {
    if (_isDisposed) return;

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

  void setImageUrl(String imageUrl) {
    if (_isDisposed) return;

    if (imageUrl.isNotEmpty) {
      if (!_isValidImageUrl(imageUrl)) {
        print('رابط الصورة غير صحيح: $imageUrl');
        emit(state.copyWith(
          error: 'رابط الصورة غير صحيح',
        ));
        return;
      }
    }

    emit(state.copyWith(
      imageUrl: imageUrl,
      error: null,
    ));
    print('تم تحديد صورة جديدة: $imageUrl');
  }

  bool _isValidImageUrl(String url) {
    if (url.isEmpty) return false;

    try {
      final uri = Uri.parse(url);
      return uri.hasScheme &&
          (uri.scheme == 'http' || uri.scheme == 'https') &&
          uri.hasAuthority;
    } catch (e) {
      return false;
    }
  }

  void removeImage() {
    if (_isDisposed) return;
    emit(state.copyWith(imageUrl: ''));
    print('تم إزالة الصورة');
  }

  void setDepartureLocation(String departureLocation) {
    if (_isDisposed) return;

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
    if (_isDisposed) return;

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
    if (_isDisposed) return;

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
    if (_isDisposed) return;

    final fieldErrors = Map<String, String>.from(state.fieldErrors);
    fieldErrors.remove('tripDate');

    emit(state.copyWith(
      tripDate: tripDate,
      fieldErrors: fieldErrors,
    ));
  }

  void setTripTime(TimeOfDay tripTime) {
    if (_isDisposed) return;

    final fieldErrors = Map<String, String>.from(state.fieldErrors);
    fieldErrors.remove('tripTime');

    emit(state.copyWith(
      tripTime: tripTime,
      fieldErrors: fieldErrors,
    ));
  }

  void setDuration(String duration) {
    if (_isDisposed) return;
    emit(state.copyWith(duration: duration));
  }

  void setPrice(double price) {
    if (_isDisposed) return;

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
    if (_isDisposed) return;
    emit(state.copyWith(additionalDetails: additionalDetails));
  }

  bool validateForm() {
    if (_isDisposed) return false;

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

    if (state.imageUrl.isNotEmpty && !_isValidImageUrl(state.imageUrl)) {
      fieldErrors['imageUrl'] = 'رابط الصورة غير صحيح';
    }

    emit(state.copyWith(fieldErrors: fieldErrors));

    return fieldErrors.isEmpty;
  }

  Future<void> _ensureUserDataLoaded() async {
    if (!_isUserDataLoaded) {
      await _loadUserData();

      if (!_isUserDataLoaded) {
        throw Exception('لم يتم تحميل بيانات المستخدم بنجاح');
      }
    }
  }

  String _getReliableDefaultImage() {
    const reliableImageUrls = [
      'https://images.unsplash.com/photo-1488646953014-85cb44e25828?w=800&h=400&fit=crop',
      'https://images.unsplash.com/photo-1469474968028-56623f02e42e?w=800&h=400&fit=crop',
      'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&h=400&fit=crop',
      'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800&h=400&fit=crop',
    ];

    final randomIndex =
        DateTime.now().millisecondsSinceEpoch % reliableImageUrls.length;
    return reliableImageUrls[randomIndex];
  }

  Future<void> submitForm() async {
    if (_isDisposed) return;

    if (!validateForm()) {
      emit(state.copyWith(
        error: 'يرجى تصحيح الأخطاء قبل الإرسال',
      ));
      return;
    }

    try {
      emit(state.copyWith(isSubmitting: true, error: null));

      await _ensureUserDataLoaded();

      String finalImageUrl = state.imageUrl;

      if (finalImageUrl.isEmpty) {
        print('لا توجد صورة محددة، استخدام صورة احتياطية موثوقة');
        finalImageUrl = _getReliableDefaultImage();
      } else if (!_isValidImageUrl(finalImageUrl)) {
        print('رابط الصورة غير صحيح، استخدام صورة احتياطية');
        finalImageUrl = _getReliableDefaultImage();
      }

      if (_isDisposed) return;

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
        imageUrl: finalImageUrl,
      );

      print('إرسال الرحلة مع الصورة: $finalImageUrl');

      final result = await _tripRepository.createTrip(tripModel);

      if (_isDisposed) return;

      result.fold((failure) {
        emit(state.copyWith(
          isSubmitting: false,
          error: failure.message,
        ));
      }, (_) {
        emit(const TripFormState());
        print('تم إنشاء الرحلة بنجاح');
      });
    } catch (e) {
      if (!_isDisposed) {
        emit(state.copyWith(
          isSubmitting: false,
          error: 'حدث خطأ غير متوقع: ${e.toString()}',
        ));
      }
    }
  }

  Future<void> updateExistingTrip(String id) async {
    if (_isDisposed) return;

    if (!validateForm()) {
      emit(state.copyWith(
        error: 'يرجى تصحيح الأخطاء قبل الإرسال',
      ));
      return;
    }

    try {
      emit(state.copyWith(isSubmitting: true, error: null));

      await _ensureUserDataLoaded();

      String finalImageUrl = state.imageUrl;

      if (finalImageUrl.isEmpty || !_isValidImageUrl(finalImageUrl)) {
        finalImageUrl = _getReliableDefaultImage();
      }

      if (_isDisposed) return;

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
        imageUrl: finalImageUrl,
      );

      final result = await _tripRepository.updateTrip(tripModel);

      if (_isDisposed) return;

      result.fold(
        (failure) {
          emit(state.copyWith(
            isSubmitting: false,
            error: failure.message,
          ));
        },
        (_) {
          emit(const TripFormState());
        },
      );
    } catch (e) {
      if (!_isDisposed) {
        emit(state.copyWith(
          isSubmitting: false,
          error: 'حدث خطأ غير متوقع: ${e.toString()}',
        ));
      }
    }
  }

  void resetForm() {
    if (_isDisposed) return;
    emit(const TripFormState());
  }

  void loadTripForEdit(TripModel trip) {
    if (_isDisposed) return;

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
        imageUrl: trip.imageUrl,
      ),
    );
  }

  bool get hasImage => state.imageUrl.isNotEmpty;
  String get currentImageUrl => state.imageUrl;
  bool get isImageValid =>
      state.imageUrl.isEmpty || _isValidImageUrl(state.imageUrl);
}
