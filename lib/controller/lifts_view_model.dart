import 'dart:js_util';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:lifts_app/repository/lifts_repository.dart';

class LiftsViewModel extends ChangeNotifier {
  User? currentUser = FirebaseAuth.instance.currentUser;
  LiftsRepository repo = LiftsRepository();
  List<Map<String, dynamic>> _lifts = [];
  List<Map<String, dynamic>> _mylifts = [];

  List<Map<String, dynamic>> get lifts => _lifts;

  List<Map<String, dynamic>> get searchResults => _mylifts;

  // Futurevoid Lift()

  Future<void> OfferLift(
      String departureStreet,
      String departureTime,
      String departureTown,
      String destinationStreet,
      String destinationTown,
      int numPassengers,
      int availableSeats,
      String costShareDescription) async {
    try {
      repo.createLift(
          currentUser!.uid,
          departureStreet,
          departureTime,
          departureTown,
          destinationStreet,
          destinationTown,
          numPassengers,
          availableSeats,
          costShareDescription);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  FirebaseFirestore _db = FirebaseFirestore.instance;

  
  Future<void> cancelLift(String id) async {
    QuerySnapshot querySnapshot =
        await _db.collection('lifts').where('id', isEqualTo: id).get();

    for (QueryDocumentSnapshot liftDoc in querySnapshot.docs) {
      await liftDoc.reference.delete();
    }
  }

  void makeBooking(String liftId, String userId) {
  _db.collection('bookings').add({
    'liftId': liftId,
    'userId': userId,
    'confirmed': true,
  });
  
}


  Future<void> findALift(String street, time) async {
    try {
      _mylifts = await repo.findLifts(currentUser!.uid, street, time) ?? [];
      notifyListeners();
    } catch (e) {
      print("Error finding a lift $e");
    }
  }

  Future<void> fetchOfferedLifts() async {
    try {
      _lifts = await repo.getOfferedLifts(currentUser!.uid) ?? [];
      notifyListeners();
    } catch (e) {
      // Handle the exception, e.g., log it or show an error message
      print('Error fetching offered lifts: $e');
    }
  }

  Future<void> fetchBookedLifts() async {
    try {
      // _lifts = await repo.
    } catch (e) {
      print("error getting booked lifts");
    }
  }
}
