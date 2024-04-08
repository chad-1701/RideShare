import 'package:flutter/material.dart';
import 'package:lifts_app/controller/lifts_view_model.dart';
import 'package:provider/provider.dart';
// import 'package:your_app/models/lifts_view_model.dart'; // Import your LiftsViewModel class

class LiftsPage extends StatefulWidget {
  @override
  _LiftsPageState createState() => _LiftsPageState();
}

class _LiftsPageState extends State<LiftsPage> {
  // Instantiate your LiftsViewModel

  @override
  void initState() {
    super.initState();
    // Call the method to fetch offered lifts when the page is first loaded
  }

  @override
  Widget build(BuildContext context) {
    // print(liftsViewModel.fetchOfferedLifts());
    final liftsViewModel = Provider.of<LiftsViewModel>(context);
    liftsViewModel.fetchOfferedLifts();
    return Scaffold(
      body: _buildLiftsList(liftsViewModel),
    );
  }

  Widget _buildLiftsList(LiftsViewModel lifts) {
    // final lifts = liftsViewModel.lifts;
    if (lifts.lifts.isEmpty) {
      return Center(
        child: Text('No offered lifts available.'),
      );
    }

    return ListView.builder(
      itemCount: lifts.lifts.length,
      itemBuilder: (context, index) {
        final lift = lifts.lifts[index];
        final availableSeats = lift['availableSeats'] ?? 0;
        final passengers = lift['numPassengers'] ?? 0;
        final destination = "${lift['destinationStreet']} , ${lift["destinationTown"]}" ?? 'N/A';
        final departureTime = lift['departureTime'] ?? 'N/A';
        final id = lift["id"] ?? "";

        return ListTile(
          leading: Icon(Icons.directions_car),
          title: Text('Destination: $destination'),
          subtitle: Text(
              'Departure Time: $departureTime\nAvailable Seats: $availableSeats\nPassengers: $passengers'),
               trailing: ElevatedButton(onPressed: () {
                 lifts.cancelLift(id);
               }, child: Text("Cancel")),
        );
      },
    );
  }
}
