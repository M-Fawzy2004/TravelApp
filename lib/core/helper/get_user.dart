import 'dart:convert';

import 'package:travel_app/constant.dart';
import 'package:travel_app/core/services/shared_preference_singleton.dart';
import 'package:travel_app/feature/auth/data/model/user_model.dart';
import 'package:travel_app/feature/auth/domain/entity/user_entity.dart';

UserEntity? getUser() {
  final jsonString = Prefs.getString(kUserData);
  if (jsonString.isEmpty) return null;
  return UserModel.fromJson(jsonDecode(jsonString));
}
