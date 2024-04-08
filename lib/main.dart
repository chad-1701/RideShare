import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lifts_app/controller/lifts_view_model.dart';
import 'package:lifts_app/firebase_options.dart';
import 'package:lifts_app/pages/bookLIft.dart';
// import 'package:lifts_app/pages/liftCancelation.dart';
import 'package:lifts_app/pages/login.dart';
import 'package:lifts_app/pages/offerLift.dart';
import 'package:lifts_app/pages/offeredLifts.dart';
import 'package:provider/provider.dart';
import 'package:lifts_app/pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp( 
    ChangeNotifierProvider(
      create: (context) => LiftsViewModel(), // Replace with your actual ChangeNotifier class
      child: const MyApp(),
    ),
  );
  // runApp(const MyApp());
  


}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "welcomePage",
      routes:{
        // "loginPage":(context)=>Login(),
        // "registrationPage":(context)=>RegisterScreen(),
        // "settings":(context)=>const SettingsView(),
        "homePage":(context)=> MyHomePage(title:""),
        "welcomePage":(context)=>Login(),
        "liftOffer":(context)=>liftOffer(),
        // "liftBooking":(context)=>liftBooking(),
        // "liftCancelation":(context)=>liftCancelation(),
        "liftsOffered":(context) => LiftsPage(),
        "liftBooking":(context)=> LiftSearchPage()

      },
      title: 'Lifts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
          create: (context) => LiftsViewModel(),
          child: const MyHomePage(title: "rideShare"),
      )
    );
  }
}
