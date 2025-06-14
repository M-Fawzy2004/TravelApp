import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/core/services/auth_service.dart';
import 'package:travel_app/feature/add_travel/data/service/trip_service.dart';
import 'package:travel_app/feature/add_travel/data/repos/trip_repo.dart';
import 'package:travel_app/feature/add_travel/data/repos/trip_repo_impl.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_form_cubit/trip_form_cubit.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_cubit/trip_cubit.dart';
import 'package:travel_app/feature/home/presentation/manager/cubit/connectivity_cubit.dart';
import 'package:travel_app/feature/position_bus/data/repo/governorate_repo_impl.dart';
import 'package:travel_app/feature/position_bus/data/service/api_service.dart';
import 'package:travel_app/feature/trip_booking/presentation/manager/booking_cubit/booking_cubit.dart';
import 'package:travel_app/feature/trip_booking/presentation/manager/favorite_cubit/favorite_cubit.dart';

final getIt = GetIt.instance;

void setupServiceLocator() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => prefs);

  // Firebase & Google
  getIt.registerLazySingleton(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(() => FirebaseFirestore.instance);
  getIt.registerLazySingleton(() => GoogleSignIn());

  // Services
  getIt.registerLazySingleton(
    () => AuthService(
      auth: getIt(),
      firestore: getIt(),
      googleSignIn: getIt(),
    ),
  );

  // Trip Feature
  // Service
  getIt.registerLazySingleton(() => TripService(firestore: getIt()));

  // Repository
  getIt.registerLazySingleton<TripRepository>(
    () => TripRepositoryImpl(service: getIt()),
  );

  // Cubits
  getIt.registerFactory(
    () => TripCubit(tripRepository: getIt()),
  );

  // booking cubit
  getIt.registerLazySingleton<BookingCubit>(() => BookingCubit());

  getIt.registerFactory(
    () => TripFormCubit(
      tripRepository: getIt(),
      authService: getIt(),
    ),
  );

  getIt.registerFactory<ConnectivityCubit>(() => ConnectivityCubit());

  getIt.registerLazySingleton<FavoriteCubit>(() => FavoriteCubit());

// في get_it_setup.dart
  getIt.registerLazySingleton<ApiService>(() => ApiService());
  getIt.registerLazySingleton<GovernorateRepoImpl>(
    () => GovernorateRepoImpl(apiService: getIt<ApiService>()),
  );
}
