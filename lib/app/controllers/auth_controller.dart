import 'package:get/get.dart';

import '../data/models/user.dart';
import '../data/repositories/prefs_repository.dart';

class AuthController extends GetxController {
  AuthController(this._prefsRepository);

  final PrefsRepository _prefsRepository;
  final Rxn<UserProfile> currentUser = Rxn<UserProfile>();

  bool get isLoggedIn => currentUser.value != null;

  @override
  void onInit() {
    super.onInit();
    final user = _prefsRepository.authUser;
    if (user != null) {
      currentUser.value = UserProfile.fromMap(user);
    }
  }

  Future<void> loginAsGuest() async {
    final user = UserProfile(
      id: 'guest',
      name: 'Guest',
      email: '',
      avatar: 'https://i.pravatar.cc/120?img=64',
      heightCm: 0,
      weightKg: 0,
      goal: 'general',
      level: 'beginner',
      locale: 'ar',
    );
    currentUser.value = user;
    await _prefsRepository.saveAuthUser(user.toMap());
  }

  Future<void> login(String email, String password) async {
    final user = UserProfile(
      id: 'u1',
      name: email.split('@').first,
      email: email,
      avatar: 'https://i.pravatar.cc/120?img=32',
      heightCm: 175,
      weightKg: 74,
      goal: 'strength',
      level: 'intermediate',
      locale: 'ar',
    );
    currentUser.value = user;
    await _prefsRepository.saveAuthUser(user.toMap());
  }

  Future<void> register(Map<String, dynamic> payload) async {
    final user = UserProfile(
      id: 'u2',
      name: payload['name'] as String,
      email: payload['email'] as String,
      avatar: 'https://i.pravatar.cc/120?img=55',
      heightCm: 0,
      weightKg: 0,
      goal: 'general',
      level: 'beginner',
      locale: 'ar',
    );
    currentUser.value = user;
    await _prefsRepository.saveAuthUser(user.toMap());
  }

  Future<void> logout() async {
    currentUser.value = null;
    await _prefsRepository.saveAuthUser(null);
  }
}
