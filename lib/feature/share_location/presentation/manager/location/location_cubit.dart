import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:travel_app/feature/share_location/data/repos/location_repo.dart';
part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final LocationRepository locationRepository;
  final Location location = Location();
  StreamSubscription<LocationData>? _locationSubscription;
  bool _isClosed = false;

  LocationCubit({required this.locationRepository}) : super(LocationInitial());

  // Initialize location
  Future<void> initializeLocation() async {
    if (_isClosed) return;
    emit(LocationLoading());
    try {
      if (!await _checkLocationPermission()) {
        if (_isClosed) return;
        emit(const LocationError('يرجى السماح بالوصول إلى الموقع'));
        return;
      }

      final locationData = await locationRepository.getCurrentLocation();
      if (_isClosed) return;

      if (locationData.latitude != null && locationData.longitude != null) {
        final currentLocation = LatLng(
          locationData.latitude!,
          locationData.longitude!,
        );
        emit(
          LocationLoaded(
            currentLocation: currentLocation,
            selectedLocation: null,
            destinationLocation: null,
            route: const [],
            isRouteVisible: false,
          ),
        );
        _subscribeToLocationChanges();
      } else {
        emit(const LocationError('فشل في الحصول على الموقع الحالي'));
      }
    } catch (e) {
      if (_isClosed) return;
      emit(const LocationError('فشل في الحصول على الموقع الحالي'));
    }
  }

  Future<bool> _checkLocationPermission() async {
    try {
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return false;
        }
      }

      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return false;
        }
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  void _subscribeToLocationChanges() {
    _locationSubscription?.cancel();
    _locationSubscription = location.onLocationChanged.listen(
      (LocationData locationData) {
        if (_isClosed) return;

        if (locationData.latitude != null && locationData.longitude != null) {
          final currentLocation =
              LatLng(locationData.latitude!, locationData.longitude!);
          if (state is LocationLoaded) {
            final currentState = state as LocationLoaded;
            emit(currentState.copyWith(currentLocation: currentLocation));
          }
        }
      },
      onError: (error) {},
      cancelOnError: false,
    );
  }

  Future<void> searchLocation(String query) async {
    if (query.isEmpty || _isClosed) return;
    final LocationLoaded? previousState = _getPreviousLoadedState();
    if (_isClosed) return;
    emit(LocationLoading());
    try {
      final result = await locationRepository.searchLocation(query);
      if (_isClosed) return;
      if (result != null) {
        if (previousState != null) {
          emit(previousState.copyWith(selectedLocation: result));
        } else {
          emit(LocationLoaded(
            currentLocation: null,
            selectedLocation: result,
            destinationLocation: null,
            route: const [],
            isRouteVisible: false,
          ));
        }
      } else {
        emit(const LocationError('هذا الموقع غير متوفر'));
        if (previousState != null && !_isClosed) {
          emit(previousState);
        }
      }
    } catch (e) {
      if (_isClosed) return;
      emit(const LocationError('حدث خطأ أثناء البحث'));
      if (previousState != null && !_isClosed) {
        emit(previousState);
      }
    }
  }

  void selectLocation(LatLng point) {
    if (_isClosed) return;
    if (state is LocationLoaded) {
      final currentState = state as LocationLoaded;
      emit(currentState.copyWith(selectedLocation: point));
    } else {
      emit(LocationLoaded(
        currentLocation: null,
        selectedLocation: point,
        destinationLocation: null,
        route: const [],
        isRouteVisible: false,
      ));
    }
  }

  Future<void> getRoute(LatLng destination) async {
    if (_isClosed || state is! LocationLoaded) return;
    final currentState = state as LocationLoaded;
    if (currentState.currentLocation == null) {
      if (_isClosed) return;
      emit(const LocationError('يجب تحديد موقعك الحالي أولاً'));
      if (!_isClosed) emit(currentState);
      return;
    }
    if (_isClosed) return;
    emit(LocationLoading());
    try {
      final routePoints = await locationRepository.getRoute(
        currentState.currentLocation!,
        destination,
      );
      if (_isClosed) return;
      if (routePoints.isNotEmpty) {
        emit(LocationLoaded(
          currentLocation: currentState.currentLocation,
          selectedLocation: currentState.selectedLocation,
          destinationLocation: destination,
          route: routePoints,
          isRouteVisible: true,
        ));
      } else {
        emit(const LocationError('لا يمكن إيجاد مسار للوجهة المحددة'));
        if (!_isClosed) emit(currentState);
      }
    } catch (e) {
      if (_isClosed) return;
      emit(LocationError('حدث خطأ أثناء تحميل المسار: $e'));
      if (!_isClosed) emit(currentState);
    }
  }

  void clearRoute() {
    if (_isClosed) return;
    if (state is LocationLoaded) {
      final currentState = state as LocationLoaded;
      emit(currentState.copyWith(
        destinationLocation: null,
        route: const [],
        isRouteVisible: false,
      ));
    }
  }

  LocationLoaded? _getPreviousLoadedState() {
    if (state is LocationLoaded) {
      return state as LocationLoaded;
    }
    return null;
  }

  @override
  Future<void> close() {
    _isClosed = true;
    _locationSubscription?.cancel();
    return super.close();
  }
}
