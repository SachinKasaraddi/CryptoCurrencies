import 'package:cryptoapp/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:cryptoapp/bloc/authentication_bloc/authentication_event.dart';
import 'package:cryptoapp/bloc/authentication_bloc/authentication_state.dart';
import 'package:cryptoapp/screen/home/dashboard.dart';
import 'package:cryptoapp/screen/login/login_screen.dart';
import 'package:cryptoapp/services/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Wrapper extends StatelessWidget {
  
  final UserRepository _userRepository;

  Wrapper({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CryptoApp',
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: ( context, state) {
          if (state is AuthenticationFailure ||
              state is AuthenticationStarted) {
            return LoginScreen(
              key: UniqueKey(),
              userRepository: _userRepository,
            );
          }

          if (state is AuthenticationSuccess) {
            return BlocProvider(
              create: (context) =>
                  AuthenticationBloc(userRepository: _userRepository),
              child: Dashboard(),
            );
          }

          return Scaffold(
            appBar: AppBar(),
            body: Container(
              child: Center(
                child: Text('Loading'),
              ),
            ),
          );
        },
      ),
    );
  }
}
