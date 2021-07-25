import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthServices with ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  void loading() {
    _isLoading = true;
    notifyListeners();
  }

  void loaded() {
    _isLoading = false;
    notifyListeners();
  }

  void setErrorMessage(String value) {
    _errorMessage = value;
    notifyListeners();
  }

  // Sign in anonymouce
  Future signInAnon() async {
    loading();
    try {
      final UserCredential result = await _auth.signInAnonymously();
      final User? user = result.user;
      loaded();
      return user;
    } on SocketException {
      loaded();
      setErrorMessage("No internet, please connect to internet");
    } catch (e) {
      loaded();
      setErrorMessage(e.toString());
    }
    notifyListeners();
  }

  // Sign in with email & password
  Future signInEmailPassword(String email, String password) async {
    loading();
    try {
      final UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User? user = result.user;
      loaded();
      return user;
    } on SocketException {
      loaded();
      setErrorMessage("No internet, please connect to internet");
    } catch (e) {
      loaded();
      setErrorMessage(e.toString());
    }
    notifyListeners();
  }

  // Register with email & password

  // Sign out
  Future signOut() async {
    await _auth.signOut();
  }

  // Get User
  Stream<User?> get user => _auth.authStateChanges().map((event) => event);
}
