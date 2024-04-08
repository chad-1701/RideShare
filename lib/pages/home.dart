import 'package:flutter/material.dart';
import 'package:lifts_app/controller/lifts_view_model.dart';
import 'package:lifts_app/pages/bookingsList.dart';
import 'package:lifts_app/pages/offeredLifts.dart';
import 'package:provider/provider.dart';
import 'package:lifts_app/pages/offerLift.dart';
import 'package:lifts_app/pages/BookLift.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: 'Lifts App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Lifts App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LiftsViewModel>(builder: (context, fuelPriceModel, child) {
      return Scaffold(
        appBar: AppBar(
          title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.directions_car),
            SizedBox(width: 8), // Add some spacing between the icon and text
            Text('SaamRy'),
          ],
        ),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Offer a Lift'),
              Tab(text: 'Book a Lift'),
              Tab(text: 'My Offers'),
              Tab(text: 'My requests'),
              

            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            liftOffer(),
            LiftSearchPage(),
            LiftsPage(),
            LiftsList()
           
          ],
        ),
      );
    });
  }

  
}
