import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LiftsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lifts List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('bookings').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          // Extracting the list of bookings from the snapshot
          List<DocumentSnapshot> bookings = snapshot.data!.docs;

          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              DocumentSnapshot booking = bookings[index];
              String liftId = booking['liftId'];

              return StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance.collection('lifts').doc().snapshots(),
                builder: (context, liftSnapshot) {
                  if (!liftSnapshot.hasData) {
                    return ListTile(title: Text('Loading...'));
                  }

                  Map<String, dynamic> liftData = liftSnapshot.data!.data() as Map<String, dynamic>;

                  return LiftTile(liftData: liftData);
                },
              );
            },
          );
        },
      ),
    );
  }
}

class LiftTile extends StatelessWidget {
  final Map<String, dynamic> liftData;

  const LiftTile({required this.liftData});

  @override
  Widget build(BuildContext context) {
    String departureStreet = liftData['departureStreet'];
    String departureTime = liftData['departureTime'];
    // Access other lift details as needed

    return ListTile(
      title: Text('Departure Street: $departureStreet'),
      subtitle: Text('Departure Time: $departureTime'),
      // Add more details as needed
    );
  }
}
