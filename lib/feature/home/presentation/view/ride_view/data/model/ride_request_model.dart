import 'package:latlong2/latlong.dart';
import 'ride_status.dart';

class RideRequestModel {
  final String id;
  final String passengerId;
  final String? driverId;
  final LatLng pickupLocation;
  final LatLng dropoffLocation;
  final List<LatLng>? routePoints;
  final RideStatus status;
  final String? secureCode;
  final double? estimatedFare;
  final double? distanceKm;
  final int? durationMin;
  final DateTime createdAt;

  RideRequestModel({
    required this.id,
    required this.passengerId,
    this.driverId,
    required this.pickupLocation,
    required this.dropoffLocation,
    this.routePoints,
    required this.status,
    this.secureCode,
    this.estimatedFare,
    this.distanceKm,
    this.durationMin,
    required this.createdAt,
  });

  factory RideRequestModel.fromMap(Map<String, dynamic> map) {
    return RideRequestModel(
      id: map['id'],
      passengerId: map['passengerId'],
      driverId: map['driverId'],
      pickupLocation: LatLng(
        map['pickupLocation']['lat'],
        map['pickupLocation']['lng'],
      ),
      dropoffLocation: LatLng(
        map['dropoffLocation']['lat'],
        map['dropoffLocation']['lng'],
      ),
      routePoints: (map['routePoints'] as List<dynamic>?)
          ?.map((point) => LatLng(point['lat'], point['lng']))
          .toList(),
      status: RideStatusExtension.fromString(map['status']),
      secureCode: map['secureCode'],
      estimatedFare: (map['estimatedFare'] as num?)?.toDouble(),
      distanceKm: (map['distanceKm'] as num?)?.toDouble(),
      durationMin: map['durationMin'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'passengerId': passengerId,
      'driverId': driverId,
      'pickupLocation': {
        'lat': pickupLocation.latitude,
        'lng': pickupLocation.longitude,
      },
      'dropoffLocation': {
        'lat': dropoffLocation.latitude,
        'lng': dropoffLocation.longitude,
      },
      'routePoints': routePoints
          ?.map((point) => {
                'lat': point.latitude,
                'lng': point.longitude,
              })
          .toList(),
      'status': status.toShortString(),
      'secureCode': secureCode,
      'estimatedFare': estimatedFare,
      'distanceKm': distanceKm,
      'durationMin': durationMin,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  RideRequestModel copyWith({
    String? id,
    String? passengerId,
    String? driverId,
    LatLng? pickupLocation,
    LatLng? dropoffLocation,
    List<LatLng>? routePoints,
    RideStatus? status,
    String? secureCode,
    double? estimatedFare,
    double? distanceKm,
    int? durationMin,
    DateTime? createdAt,
  }) {
    return RideRequestModel(
      id: id ?? this.id,
      passengerId: passengerId ?? this.passengerId,
      driverId: driverId ?? this.driverId,
      pickupLocation: pickupLocation ?? this.pickupLocation,
      dropoffLocation: dropoffLocation ?? this.dropoffLocation,
      routePoints: routePoints ?? this.routePoints,
      status: status ?? this.status,
      secureCode: secureCode ?? this.secureCode,
      estimatedFare: estimatedFare ?? this.estimatedFare,
      distanceKm: distanceKm ?? this.distanceKm,
      durationMin: durationMin ?? this.durationMin,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
