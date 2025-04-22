import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_app/constant.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';

class TripService {
  final FirebaseFirestore _firestore;

  TripService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<TripModel>> getTripsByCaptainId(String captainId) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection(tripCollection)
          .where('creatorId', isEqualTo: captainId)
          .get();

      final trips = querySnapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return TripModel.fromJson(data);
      }).toList();

      return trips;
    } catch (e) {
      throw Exception('حدث خطأ أثناء تحميل الرحلات');
    }
  }

  Future<List<TripModel>> getAllTrips() async {
    try {
      final querySnapshot = await _firestore.collection(tripCollection).get();
      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> tripData = doc.data();
        tripData['id'] = doc.id;
        return TripModel.fromJson(tripData);
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch trips: $e');
    }
  }

  Future<TripModel> getTripById(String id) async {
    try {
      final docSnapshot =
          await _firestore.collection(tripCollection).doc(id).get();
      if (!docSnapshot.exists) {
        throw Exception('Trip not found');
      }

      final data = docSnapshot.data();
      if (data == null) {
        throw Exception('Trip data is null');
      }

      Map<String, dynamic> tripData = data;
      tripData['id'] = docSnapshot.id;
      return TripModel.fromJson(tripData);
    } catch (e) {
      throw Exception('Failed to fetch trip: $e');
    }
  }

  Future<void> createTrip(TripModel trip) async {
    try {
      final tripData = trip.toJson();
      tripData.remove('id');
      await _firestore.collection(tripCollection).add(tripData);
    } catch (e) {
      throw Exception('Failed to create trip: $e');
    }
  }

  Future<void> updateTrip(TripModel trip) async {
    try {
      final tripData = trip.toJson();
      tripData.remove('id');
      await _firestore.collection(tripCollection).doc(trip.id).update(tripData);
    } catch (e) {
      throw Exception('Failed to update trip: $e');
    }
  }

  Future<void> deleteTrip(String id) async {
    try {
      await _firestore.collection(tripCollection).doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete trip: $e');
    }
  }

  Future<List<TripModel>> searchTrips({
    TripType? tripType,
    String? destination,
    DateTime? date,
  }) async {
    try {
      Query query = _firestore.collection(tripCollection);

      if (tripType != null) {
        query = query.where('tripType',
            isEqualTo: tripType.toString().split('.').last);
      }

      if (destination != null && destination.isNotEmpty) {
        query = query.where('destinationName', isEqualTo: destination);
      }

      if (date != null) {
        final nextDay = DateTime(date.year, date.month, date.day + 1);
        query = query
            .where('tripDate', isGreaterThanOrEqualTo: date.toIso8601String())
            .where('tripDate', isLessThan: nextDay.toIso8601String());
      }

      final querySnapshot = await query.get();
      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> tripData = doc.data() as Map<String, dynamic>;
        tripData['id'] = doc.id;
        return TripModel.fromJson(tripData);
      }).toList();
    } catch (e) {
      throw Exception('Failed to search trips: $e');
    }
  }
}
