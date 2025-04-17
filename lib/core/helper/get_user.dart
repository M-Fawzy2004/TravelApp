import 'dart:convert';

import 'package:travel_app/core/services/shared_preference_singleton.dart';
import 'package:travel_app/feature/login/data/model/user_model.dart';

import '../../feature/login/domain/entity/user_entity.dart';

Future<bool> saveUserAfterLogin(UserModel user) async {
  try {
    // Convert to JSON
    final userMap = user.toJson();

    // Convert to JSON string
    final jsonString = jsonEncode(userMap);

    // Save to SharedPreferences
    await Prefs.setString('users', jsonString);

    // Verify it was saved correctly
    final savedString = Prefs.getString('users');
    print('User saved successfully: $savedString');

    return savedString.isNotEmpty;
  } catch (e) {
    print('Error saving user data: $e');
    return false;
  }
}

UserEntity? getUser() {
  try {
    // Get the string from SharedPreferences
    var jsonString = Prefs.getString('users');
    print('Retrieved user string: "$jsonString"');

    // Check if the string is empty
    if (jsonString.isEmpty) {
      print('User data is empty in SharedPreferences');
      return null;
    }

    // Try to parse JSON
    var jsonData = jsonDecode(jsonString);
    print('Parsed JSON data: $jsonData');

    // Create user entity
    var userEntity = UserModel.fromJson(jsonData);
    print('Created user entity with phone: ${userEntity.phoneNumber}');

    return userEntity;
  } catch (e) {
    print('Error retrieving user: $e');
    return null;
  }
}
