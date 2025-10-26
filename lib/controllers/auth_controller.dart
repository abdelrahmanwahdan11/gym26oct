import 'package:flutter/material.dart';

import '../data/models/user.dart';
import '../data/repositories/prefs_repository.dart';

class AuthController extends ChangeNotifier {
  AuthController(this.prefs);

  final PrefsRepository prefs;

  User? _user;

  User? get user => _user;
  bool get isLoggedIn => _user != null;

  Future<void> bootstrap() async {
    _user = User(
      id: 'u1',
      name: 'Athletica User',
      email: 'user@example.com',
      avatar: 'https://i.pravatar.cc/120?img=64',
      heightCm: 175,
      weightKg: 70,
      goal: 'Build Strength',
      level: 'Intermediate',
      locale: prefs.loadLocale().languageCode,
    );
    notifyListeners();
  }

  Future<void> loginMock(String email) async {
    _user = User(
      id: 'u1',
      name: email.split('@').first,
      email: email,
      avatar: 'https://i.pravatar.cc/120?img=65',
      heightCm: 175,
      weightKg: 70,
      goal: 'Build Strength',
      level: 'Intermediate',
      locale: prefs.loadLocale().languageCode,
    );
    notifyListeners();
  }

  Future<void> registerMock({required String name, required String email}) async {
    _user = User(
      id: 'u2',
      name: name,
      email: email,
      avatar: 'https://i.pravatar.cc/120?img=66',
      heightCm: 170,
      weightKg: 68,
      goal: 'Custom Goal',
      level: 'Beginner',
      locale: prefs.loadLocale().languageCode,
    );
    notifyListeners();
  }

  Future<void> loginAsGuest() async {
    _user = User(
      id: 'guest',
      name: 'Guest Explorer',
      email: 'guest@athletica.app',
      avatar: 'https://i.pravatar.cc/120?img=67',
      heightCm: 0,
      weightKg: 0,
      goal: 'Discover',
      level: 'Guest',
      locale: prefs.loadLocale().languageCode,
    );
    notifyListeners();
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
