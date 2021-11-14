import 'package:flutter/material.dart';

import 'models.dart';

class ProfileManager extends ChangeNotifier {
  User get getUser => User(
        firstName: 'Stef',
        lastName: 'Patt',
        role: 'Flutterista',
        profileImageUrl: 'assets/profile_pics/person_stef.jpeg',
        points: 100,
        darkMode: _darkMode,
      );

  bool get didSelectUser => _didSelectUser;
  bool get didTapOnAbout => _tapOnAbout;
  bool get darkMode => _darkMode;

  var _didSelectUser = false;
  var _tapOnAbout = false;
  var _darkMode = false;

  set darkMode(bool toggle) {
    _darkMode = toggle;
    notifyListeners();
  }

  void tapOnAbout(bool toggle) {
    _tapOnAbout = toggle;
    notifyListeners();
  }

  void tapOnProfile(bool toggle) {
    _didSelectUser = toggle;
    notifyListeners();
  }
}
