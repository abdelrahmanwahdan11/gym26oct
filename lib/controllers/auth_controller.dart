import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/models/user.dart';
import '../data/repositories/prefs_repository.dart';

class AuthController extends GetxController {
  AuthController(this.prefs);

  final PrefsRepository prefs;

  User? _user;

  User? get user => _user;

  @override
  void onInit() {
    super.onInit();
    bootstrap();
  }

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
    update();
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
    update();
  }
}
