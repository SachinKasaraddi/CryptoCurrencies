import 'package:cryptoapp/screen/register/register_screen.dart';
import 'package:cryptoapp/services/repositories/user_repository.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RegisterScreen(key: UniqueKey(),userRepository: UserRepository(),);
  }
}