import 'package:travel_app/feature/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    super.firstName,
    super.lastName,
    super.city,
    required super.phoneNumber,
    super.email,
    super.role,
    super.vehicleType,
    super.seatCount,
    super.isEmailVerified,
    super.latitude,
    super.longitude,
    super.locationName,
  });

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      firstName: entity.firstName,
      lastName: entity.lastName,
      city: entity.city,
      phoneNumber: entity.phoneNumber,
      email: entity.email,
      role: entity.role ?? UserRole.passenger,
      vehicleType: entity.vehicleType ?? VehicleType.privateCar,
      seatCount: entity.seatCount,
      isEmailVerified: entity.isEmailVerified,
      latitude: entity.latitude,
      longitude: entity.longitude,
      locationName: entity.locationName,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      firstName: json['firstName'],
      lastName: json['lastName'],
      city: json['city'],
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'],
      role: json['role'] != null
          ? UserRole.values.firstWhere(
              (e) => e.toString() == 'UserRole.${json['role']}',
              orElse: () => UserRole.passenger,
            )
          : null,
      vehicleType: json['vehicleType'] != null
          ? VehicleType.values.firstWhere(
              (e) => e.toString() == 'VehicleType.${json['vehicleType']}',
              orElse: () => VehicleType.privateCar,
            )
          : null,
      seatCount: json['seatCount'],
      isEmailVerified: json['isEmailVerified'] ?? false,
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      locationName: json['locationName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'city': city,
      'phoneNumber': phoneNumber,
      'email': email,
      'role': role?.toString().split('.').last,
      'vehicleType': vehicleType?.toString().split('.').last,
      'seatCount': seatCount,
      'isEmailVerified': isEmailVerified,
      'latitude': latitude,
      'longitude': longitude,
      'locationName': locationName,
    };
  }

  // Helper method to create a new model with updated location
  UserModel copyWithLocation({
    required double latitude,
    required double longitude,
    required String locationName,
  }) {
    return UserModel(
      id: id,
      firstName: firstName,
      lastName: lastName,
      city: city,
      phoneNumber: phoneNumber,
      email: email,
      role: role,
      vehicleType: vehicleType,
      seatCount: seatCount,
      isEmailVerified: isEmailVerified,
      latitude: latitude,
      longitude: longitude,
      locationName: locationName,
    );
  }
}
