import 'package:cryptoapp/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:cryptoapp/screen/wrapper.dart';
import 'package:cryptoapp/services/repositories/user_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/authentication_bloc/authentication_event.dart';

void main() {
  runApp(
    new MaterialApp(
      title: 'CryptoApp',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text('Something went wrong, Please try later');
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return BlocProvider(
            create: (context) =>
                AuthenticationBloc(userRepository: UserRepository())
                  ..add(AuthenticationStarted()),
            child: Wrapper(
              userRepository: UserRepository(),
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return CircularProgressIndicator();
      },
    );
  }
}
