import 'package:cryptoapp/bloc/register_bloc/register_bloc.dart';
import 'package:cryptoapp/screen/register/register_form.dart';
import 'package:cryptoapp/services/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  final UserRepository _userRepository;

  const RegisterScreen(
      {required Key key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Color(0xff6a515e),
        ),
      ),
      body: BlocProvider<RegisterBloc>(
        create: (context) => RegisterBloc(userRepository: _userRepository),
        child: Container(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 100, left: 50),
                  width: double.infinity,
                  height: 300,
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 230),
                  child: RegisterForm(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
