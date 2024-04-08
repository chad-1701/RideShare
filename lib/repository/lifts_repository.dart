import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifts_app/controller/lifts_view_model.dart';
import 'package:lifts_app/model/lift.dart';

import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../model/lift.dart';

/// Manages storing and retrieval of Lifts from Firebase
/// The idea is that you use a class like this in LiftsViewModel, instead of using FirebaseFirestore SDK directly from views
class LiftsRepository {
  var logger = Logger();
  FirebaseFirestore _db = FirebaseFirestore.instance;
  // LiftsViewModel liftsViewModel = Provider.of<LiftsViewModel>(context)

  //TODO: implement create, update and retrieve methods

  //FIND A WAY TO UNIQUELY IDENTIFY EACH USER BASED ON THEIR lOGIN
  //FIND A WAY TO DISTINGUISH BETWEEN THE ONE WHO OFFERED A LIFT AND THE ONE WHO REQUESTED

  //CREATE A LIFT AND ADD IT TO THE FIREBASE COLLECTION
  //ADD TO YOUR LIST OF LIFTS
  //DELETE/CANCEL A LIFT YOU'VE MADE
  //GET ALL THE LIFTS YOU'VE REQUESTED/OFFERED

  Future<List<Map<String, dynamic>>?> getOfferedLifts(String userId) async {
    try {
      final liftsQuery = await _db
          .collection("lifts")
          .where("userId", isEqualTo: userId)
          .get();
      final lifts = liftsQuery.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      return lifts;
    } catch (e) {
      // Handle the exception, e.g., log it or return null
      print('Error fetching offered lifts: $e');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> getBookedLifts(String userId) async {
    final liftsQuery =
        await _db.collection("lifts").where("", isEqualTo: userId).get();
    final lifts = liftsQuery.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
    return lifts;
  }

  void createLift(
    String userId,
    String departureStreet,
    String departureTime,
    String departureTown,
    String destinationStreet,
    String destinationTown,
    int numPassengers,
    int availableSeats,
    String costShareDescription,
  ) {
    var uuid = Uuid();
    _db.collection("lifts").add({
      "userId": userId,
      "departureStreet": departureStreet,
      "departureTime": departureTime,
      "departureTown": departureTown,
      "costShareDescription": costShareDescription,
      "destinationStreet": destinationStreet,
      "destinationTown":destinationTown,
      "numPassengers": numPassengers,
      "availableSeats": availableSeats,
      "id": uuid.v4()
    });
  }

  Future<List<Map<String, dynamic>>?> findLifts(
      userId, String streetAddress, String time) async {
    try {
      final myLiftsQuery = await _db
          .collection("lifts")
          .where("userId", isEqualTo: userId)
          .where("destinationStreet", isEqualTo: streetAddress)
          // .where("availableSeats",isGreaterThan: 0)
          // .where("destinationTown", isEqualTo: Town)
          // .where("departureTime", isGreaterThan: time)
          .get();
      final myLifts = await myLiftsQuery.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      return myLifts;
    } catch (e) {
      print(e);
    }
  }

  void createBooking(
    String userId,

  ) {}



  void BookLift(
  ) {}
}
