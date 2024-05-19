import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  final FirebaseAuth _auth;

  AuthRepo({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

  Stream<User?> get user => _auth.authStateChanges().map((user) => user);

  User? get currentUser => _auth.currentUser;

  Future<void> login({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw LoginException.fromCode(e.code);
    } catch (e) {
      throw LoginException();
    }
  }

  Future<void> signup({required String email, required String password, required String username}) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw RegisterException.fromCode(e.code);
    } catch (e) {
      throw RegisterException();
    }
  }

  Future<void> logout() async => await _auth.signOut();

  Future<void> register({required String email, required String password, required String username}) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await _auth.currentUser!.updateDisplayName(username);
    } on FirebaseAuthException catch (e) {
      throw RegisterException.fromCode(e.code);
    } catch (e) {
      throw RegisterException();
    }
  }
}

class LoginException implements Exception {
  final String message;

  LoginException({this.message = "Something went wrong. Please try again later."});

  factory LoginException.fromCode(String code) {
    switch (code) {
      case "user-not-found":
        return LoginException(message: "User not found.");
      case "wrong-password":
        return LoginException(message: "Wrong password.");
      case "user-disabled":
        return LoginException(message: "User disabled.");
      case "too-many-requests":
        return LoginException(message: "Too many requests. Please try again later.");
      case "operation-not-allowed":
        return LoginException(message: "Operation not allowed.");
      case "invalid-credential":
        return LoginException(message: "Email or password is incorrect.");
      default:
        return LoginException();
    }
  }
}

class RegisterException implements Exception {
  final String message;

  RegisterException({this.message = "Something went wrong. Please try again later."});

  factory RegisterException.fromCode(String code) {
    switch (code) {
      case "email-already-in-use":
        return RegisterException(message: "Email already in use.");
      case "invalid-email":
        return RegisterException(message: "Invalid email.");
      case "operation-not-allowed":
        return RegisterException(message: "Operation not allowed.");
      case "weak-password":
        return RegisterException(message: "Weak password.");
      case "too-many-requests":
        return RegisterException(message: "Too many requests. Please try again later.");
      default:
        return RegisterException();
    }
  }
}
