import 'package:flutter/material.dart';
import '../data/mock_users.dart';

/// Holds whoever is currently "logged in" for this demo session.
class AuthStore extends ChangeNotifier {
  AuthStore._internal();
  static final AuthStore instance = AuthStore._internal();

  MockUser? currentUser;

  void login(MockUser user) {
    currentUser = user;
    notifyListeners();
  }

  void logout() {
    currentUser = null;
    notifyListeners();
  }
}
