import 'package:flutter/material.dart';
import 'package:lifts_app/controller/lifts_view_model.dart';
import 'package:provider/provider.dart';

class LiftSearchPage extends StatefulWidget {
  @override
  _LiftSearchPageState createState() => _LiftSearchPageState();
}

class _LiftSearchPageState extends State<LiftSearchPage> {
  final TextEditingController _destinationController = TextEditingController();
  late final liftsModel = Provider.of<LiftsViewModel>(context);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _destinationController,
              decoration: InputDecoration(
                labelText: 'Enter Destination',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final List<String> destination =
                    "${_destinationController.text.trim()},".split(",");
                final String town = destination[1];
                final String street = destination[0];
                if (destination[0].isNotEmpty) {
                  // Call the method to search lifts by destination
                  setState(() async {
                    await liftsModel.findALift(
                        street, DateTime.now().toString());
                    // print(liftsModel.searchResults);
                  });
                }
              },
              child: Text('Search'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: _buildSearchResults(liftsModel),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults(LiftsViewModel liftsModel) {
    final searchResults = liftsModel.searchResults;
    // print(searchResults);
    if (searchResults.isEmpty) {
      return Center(
        child: Text('No lifts found for the entered destination.'),
      );
    }

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final lift = searchResults[index];
        final availableSeats = lift['availableSeats'] ?? 0;
        final passengers = lift['numPassengers'] ?? 0;
        final destination =
            "${lift['destinationStreet']} , ${lift["destinationTown"]}" ??
                'N/A';
        final departureTime = lift['departureTime'] ?? 'N/A';

        return ListTile(
          leading: Icon(Icons.directions_car),
          title: Text('Destination: $destination'),
          subtitle: Text(
              'Departure Time: $departureTime\nAvailable Seats: $availableSeats\nPassengers: $passengers'),
          trailing: ElevatedButton(
              onPressed: () {
                liftsModel.makeBooking(lift["id"], liftsModel.currentUser!.uid);
              },
              child: Text("Book")),
        );
      },
    );
  }
}
