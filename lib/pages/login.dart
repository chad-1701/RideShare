import 'package:flutter/material.dart';

import "package:firebase_auth/firebase_auth.dart" hide EmailAuthProvider;
import "package:firebase_ui_auth/firebase_ui_auth.dart";

import 'package:lifts_app/pages/home.dart';
import 'package:lifts_app/repository/lifts_repository.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Map<String, dynamic> userData = {};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String email;
  late String password;

  // static final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SignInScreen(
              providers: [
                EmailAuthProvider(),
              ],
            );
          } else {
            
            return MyHomePage(title: "");
          }
        });
  }
}
