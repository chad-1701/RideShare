import 'package:flutter/material.dart';
import 'package:lifts_app/controller/lifts_view_model.dart';
import 'package:lifts_app/pages/offerLift.dart';
import 'package:lifts_app/repository/lifts_repository.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:provider/provider.dart';

class liftOffer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _liftOffer();
}

class _liftOffer extends State<liftOffer> {
  final _formKey = GlobalKey<FormState>();

  // Define variables to store form data
  String departureStreet = '';
  String departureTime = '';
  String departureTown = '';
  String destinationStreet = '';
  String destinationTown = '';
  int numPassengers = 0;
  int availableSeats = 0;
  String costShareDescription = '';
  @override
  Widget build(BuildContext context) {
  final liftsModel = Provider.of<LiftsViewModel>(context);
  return Scaffold(
    body: Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 400, // Adjust the value based on your preference
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildTextFormField(
                    labelText: 'Departure Street',
                    onChanged: (value) {
                      setState(() {
                        departureStreet = value;
                      });
                    },
                  ),
                  buildDateTimeField(
  labelText: 'Departure Time',
  onChanged: (value) {
    setState(() {
      departureTime = value != null
          ? DateFormat("yyyy-MM-dd HH:mm").format(value)
          : ''; // Handle null value appropriately
    });
  },
),

                  buildTextFormField(
                    labelText: 'Departure Town',
                    onChanged: (value) {
                      setState(() {
                        departureTown = value;
                      });
                    },
                  ),
                  buildTextFormField(
                    labelText: 'Destination Street',
                    onChanged: (value) {
                      setState(() {
                        destinationStreet = value;
                      });
                    },
                  ),
                  buildTextFormField(
                    labelText: 'Destination Town',
                    onChanged: (value) {
                      setState(() {
                        destinationTown = value;
                      });
                    },
                  ),
                  buildTextFormField(
                    labelText: 'Number of Passengers',
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        numPassengers = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                  buildTextFormField(
                    labelText: 'Available Seats',
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        availableSeats = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                  buildTextFormField(
                    labelText: 'Cost Share Description',
                    onChanged: (value) {
                      setState(() {
                        costShareDescription = value;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          departureStreet.isNotEmpty &&
                          departureTime.isNotEmpty &&
                          departureTown.isNotEmpty &&
                          destinationStreet.isNotEmpty &&
                          destinationTown.isNotEmpty &&
                          numPassengers != null &&
                          availableSeats != null &&
                          costShareDescription.isNotEmpty) {
                        // Perform actions with form data
                        // For example, you can send the data to an API or store it locally
                        // Print the values for demonstration purposes
                        print('Departure Street: $departureStreet');
                        print('Departure Time: $departureTime');
                        print('Departure Town: $departureTown');
                        print('Destination Street: $destinationStreet');
                        print('Destination Town: $destinationTown');
                        print('Number of Passengers: $numPassengers');
                        print('Available Seats: $availableSeats');
                        print('Cost Share Description: $costShareDescription');

                        // Call the method to offer the lift
                        liftsModel.OfferLift(
                          departureStreet.toLowerCase()!,
                          departureTime!,
                          departureTown!.toLowerCase(),
                          destinationStreet!.toLowerCase(),
                          destinationTown!.toLowerCase(),
                          numPassengers!,
                          availableSeats!,
                          costShareDescription!,
                        );
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}



  Widget buildTextFormField({
    required String labelText,
    required ValueChanged<String> onChanged,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
        ),
        onChanged: onChanged,
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty ) {
            return 'Please enter a value';
          }
          return null;
        },
      ),
    );
  }

  Widget buildDateTimeField({
    required String labelText,
    required ValueChanged<DateTime?> onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: DateTimeField(
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
        ),
        format: DateFormat("yyyy-MM-dd HH:mm"),
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
            context: context,
            firstDate: DateTime(2000),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2101),
          );

          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );

            if (time != null) {
              return DateTime(
                  date.year, date.month, date.day, time.hour, time.minute);
            }
          }

          return currentValue;
        },
        onChanged: onChanged,
        validator: (value) {
          // if (value != null) {
          //   return 'Please enter a date/time';
          // }
          return null;
        },
      ),
    );
  }
}