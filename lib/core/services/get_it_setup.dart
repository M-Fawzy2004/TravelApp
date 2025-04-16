import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travel_app/core/services/auth_service.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
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
}
