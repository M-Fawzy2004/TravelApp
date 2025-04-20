import 'package:flutter/material.dart';

class FormControllers {
  final destinationController = TextEditingController();
  final departureLocationController = TextEditingController();
  final arrivalLocationController = TextEditingController();
  final seatsController = TextEditingController();
  final durationController = TextEditingController();
  final priceController = TextEditingController();
  final detailsController = TextEditingController();

  void dispose() {
    destinationController.dispose();
    departureLocationController.dispose();
    arrivalLocationController.dispose();
    seatsController.dispose();
    durationController.dispose();
    priceController.dispose();
    detailsController.dispose();
  }
}
