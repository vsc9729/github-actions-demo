import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:navigation_project/services/auth_service.dart';

class LoginInfoProvider extends ChangeNotifier {
  bool isLoggedIn = AuthService(FirebaseAuth.instance).isLoggedIn();
  void setLoggedInStatus(bool value) {
    isLoggedIn = value;
    notifyListeners();
  }
}
