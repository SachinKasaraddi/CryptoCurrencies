import 'package:cryptoapp/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () {
            dynamic user = _authService.signInAnonymously();
            if (user == null) {
              print('Error signing in');
            } else {
              print(user.toString());
            }
          },
          child: Text('Sign In'),
        ),
      ),
    );
  }
}
