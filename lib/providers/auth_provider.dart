import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../api/firebase_auth_api.dart';

class AuthProvider with ChangeNotifier {
  late FirebaseAuthAPI authService;
  late Stream<User?> uStream;
  User? userObj;

  AuthProvider() {
    authService = FirebaseAuthAPI();
    fetchAuthentication();
  }

  Stream<User?> get userStream => uStream;

  void fetchAuthentication() {
    uStream = authService.getUser();

    notifyListeners();
  }

  Future<String> signUp(String email, String password) async {
    String errorMessage = await authService.signUp(email, password);
    notifyListeners();
    return errorMessage;
  }

  Future<String> signIn(String email, String password) async {
    String errorMessage = await authService.signIn(email, password);
    notifyListeners();
    return errorMessage;
  }

  Future<void> signOut() async {
    await authService.signOut();
    notifyListeners();
  }
}
