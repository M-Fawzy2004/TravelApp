// Updated TripModel with simplified image handling
import 'package:flutter/material.dart';
import 'package:travel_app/core/utils/tripe_type.dart';

class TripModel {
  final String id;
  final String creatorId;
  final String creatorFirstName;
  final String creatorLastName;
  final String creatorPhone;
  final TripType tripType;
  final String destinationName;
  final String departureLocation;
  final String arrivalLocation;
  final int availableSeats;
  final DateTime tripDate;
  final TimeOfDay tripTime;
  final String duration;
  final double price;
  final String additionalDetails;
  final String imageUrl;

  TripModel({
    required this.id,
    required this.creatorId,
    required this.creatorFirstName,
    required this.creatorLastName,
    required this.creatorPhone,
    required this.tripType,
    required this.destinationName,
    required this.departureLocation,
    required this.arrivalLocation,
    required this.availableSeats,
    required this.tripDate,
    required this.tripTime,
    required this.duration,
    required this.price,
    this.additionalDetails = '',
    this.imageUrl = '',
  });

  String getTripTypeArabicText() {
    return getTripTypeInArabic(tripType);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'creatorId': creatorId,
      'creatorFirstName': creatorFirstName,
      'creatorLastName': creatorLastName,
      'creatorPhone': creatorPhone,
      'tripType': tripType.toString().split('.').last,
      'destinationName': destinationName,
      'departureLocation': departureLocation,
      'arrivalLocation': arrivalLocation,
      'availableSeats': availableSeats,
      'tripDate': tripDate.toIso8601String(),
      'tripTime': '${tripTime.hour}:${tripTime.minute}',
      'duration': duration,
      'price': price,
      'additionalDetails': additionalDetails,
      'imageUrl': imageUrl,
    };
  }

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      id: json['id'],
      creatorId: json['creatorId'],
      creatorFirstName: json['creatorFirstName'],
      creatorLastName: json['creatorLastName'],
      creatorPhone: json['creatorPhone'],
      tripType: TripType.values.firstWhere(
        (e) => e.toString().split('.').last == json['tripType'],
        orElse: () => TripType.privateDelivery,
      ),
      destinationName: json['destinationName'],
      departureLocation: json['departureLocation'],
      arrivalLocation: json['arrivalLocation'],
      availableSeats: json['availableSeats'],
      tripDate: DateTime.parse(json['tripDate']),
      tripTime: TimeOfDay(
        hour: int.parse(json['tripTime'].split(':')[0]),
        minute: int.parse(json['tripTime'].split(':')[1]),
      ),
      duration: json['duration'],
      price: json['price'].toDouble(),
      additionalDetails: json['additionalDetails'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  TripModel copyWith({
    String? id,
    String? creatorId,
    String? creatorFirstName,
    String? creatorLastName,
    String? creatorPhone,
    TripType? tripType,
    String? destinationName,
    String? departureLocation,
    String? arrivalLocation,
    int? availableSeats,
    DateTime? tripDate,
    TimeOfDay? tripTime,
    String? duration,
    double? price,
    String? additionalDetails,
    String? imageUrl,
  }) {
    return TripModel(
      id: id ?? this.id,
      creatorId: creatorId ?? this.creatorId,
      creatorFirstName: creatorFirstName ?? this.creatorFirstName,
      creatorLastName: creatorLastName ?? this.creatorLastName,
      creatorPhone: creatorPhone ?? this.creatorPhone,
      tripType: tripType ?? this.tripType,
      destinationName: destinationName ?? this.destinationName,
      departureLocation: departureLocation ?? this.departureLocation,
      arrivalLocation: arrivalLocation ?? this.arrivalLocation,
      availableSeats: availableSeats ?? this.availableSeats,
      tripDate: tripDate ?? this.tripDate,
      tripTime: tripTime ?? this.tripTime,
      duration: duration ?? this.duration,
      price: price ?? this.price,
      additionalDetails: additionalDetails ?? this.additionalDetails,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  static String getDefaultCityImage(String cityName) {
    return 'https://source.unsplash.com/800x400/?$cityName,egypt,travel,city';
  }

  static String getDefaultTravelImage() {
    return 'https://source.unsplash.com/800x400/?egypt,travel,road,journey';
  }

  bool hasImage() {
    return imageUrl.isNotEmpty;
  }

  String getImageUrlOrDefault() {
    return imageUrl.isNotEmpty ? imageUrl : getDefaultTravelImage();
  }
}

enum TripType { specialTrip, privateDelivery }
