import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepository() : _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> signUp(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<User?> getUser() async {
    return _firebaseAuth.currentUser;
  }
}
