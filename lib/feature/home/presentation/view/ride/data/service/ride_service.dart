import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_app/constant.dart';
import 'package:travel_app/feature/home/presentation/view/ride/data/model/ride_request_model.dart';
import 'package:travel_app/feature/home/presentation/view/ride/data/model/ride_status.dart';

class RideService {
  final rideService = FirebaseFirestore.instance.collection(kRideRequests);

  // create ride
  Future<void> createRide(RideRequestModel ride) async {
    try {
      await rideService.doc(ride.id).set(ride.toMap());
    } on Exception {
      Exception('حدث خطأ أثناء إنشاء الرحلة:');
    }
  }

  // update ride
  Future<void> updateRide(String id, Map<String, dynamic> data) async {
    try {
      await rideService.doc(id).update(data);
    } on Exception {
      Exception('حدث خطاء اثناء تحديث الرحلة:');
    }
  }

  // get ride by id
  Future<RideRequestModel?> getRideById(String id) async {
    try {
      final doc = await rideService.doc(id).get();
      if (doc.exists) {
        return RideRequestModel.fromMap(doc.data()!);
      }
      return null;
    } catch (e) {
      throw Exception('خطأ أثناء تحميل الطلب: $e');
    }
  }

  // get ride status
  Future<List<RideRequestModel>> getRidesByStatus(RideStatus status) async {
    try {
      final snapshot = await rideService
          .where('status', isEqualTo: status.toShortString())
          .get();

      return snapshot.docs
          .map((doc) => RideRequestModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('فشل في جلب الرحلات حسب الحالة: $e');
    }
  }

  // listen to ride
  Stream<RideRequestModel?> listenToRide(String id) {
    return rideService.doc(id).snapshots().map(
      (snapshot) {
        if (snapshot.exists && snapshot.data() != null) {
          return RideRequestModel.fromMap(snapshot.data()!);
        }
        return null;
      },
    );
  }

  // delete ride
  Future<void> deleteRide(String id) async {
    try {
      await rideService.doc(id).delete();
    } on Exception {
      Exception('حدث خطاء اثناء حذف الرحلة:');
    }
  }
}
