import 'package:flutter/material.dart';
import 'dart:async';

import 'app_cache.dart';

// 1
class FooderlichTab {
  static const int explore = 0;
  static const int recipes = 1;
  static const int basket = 2;
}

class AppStateManager extends ChangeNotifier {
  // 2
  bool _initialized = false;
  // 3
  bool _loggedIn = false;
  // 4
  bool _onboardingComplete = false;
  // 5
  int _selectedTab = FooderlichTab.explore;
  final _appCache = AppCache();

  // 6
  bool get isInitialized => _initialized;
  bool get isLoggedIn => _loggedIn;
  bool get isOnboardingComplete => _onboardingComplete;
  int get getSelectedTab => _selectedTab;

  void initializeApp() async {
    _loggedIn = await _appCache.isUserLoggedIn();
    _onboardingComplete = await _appCache.didCompleteOnboarding();
    // 7
    Timer(
      const Duration(milliseconds: 2000),
      () {
        // 8
        _initialized = true;
        // 9
        notifyListeners();
      },
    );
  }

  void login(String username, String password) async {
    // 10
    _loggedIn = true;
    await _appCache.cacheUser();
    // 11
    notifyListeners();
  }

  void completeOnboarding() async {
    _onboardingComplete = true;
    await _appCache.completeOnboarding();
    notifyListeners();
  }

  void goToTab(index) {
    _selectedTab = index;
    notifyListeners();
  }

  void goToRecipes() {
    _selectedTab = FooderlichTab.recipes;
    notifyListeners();
  }

  void logout() async {
    // 12
    // _loggedIn = false;
    // _onboardingComplete = false;
    _initialized = false;
    _selectedTab = 0;
    await _appCache.invalidate();

    // 13
    initializeApp();
    // 14
    notifyListeners();
  }
}
