import 'package:flutter/material.dart';

import '../data/models/challenge.dart';
import '../data/repositories/challenge_repository.dart';
import '../data/repositories/prefs_repository.dart';

class ChallengesController extends ChangeNotifier {
  ChallengesController(this.repository, this.prefs);

  final ChallengeRepository repository;
  final PrefsRepository prefs;

  final List<Challenge> _challenges = [];
  final Set<String> _completedIds = <String>{};
  final Map<String, int> _shareCounts = <String, int>{};
  bool _isLoading = false;

  List<Challenge> get challenges => List.unmodifiable(_challenges);
  bool get isLoading => _isLoading;
  Set<String> get completedIds => _completedIds;
  Map<String, int> get shareCounts => Map.unmodifiable(_shareCounts);

  Map<String, List<Challenge>> get groupedByCategory {
    final map = <String, List<Challenge>>{};
    for (final challenge in _challenges) {
      map.putIfAbsent(challenge.category, () => <Challenge>[]).add(challenge);
    }
    return map;
  }

  Future<void> bootstrap() async {
    _isLoading = true;
    notifyListeners();
    _completedIds
      ..clear()
      ..addAll(prefs.loadCompletedChallenges());
    _shareCounts.clear();
    final items = await repository.fetchChallenges();
    _challenges
      ..clear()
      ..addAll(items);
    _isLoading = false;
    notifyListeners();
  }

  bool isCompleted(String id) => _completedIds.contains(id);

  Future<void> toggleComplete(String id) async {
    if (_completedIds.contains(id)) {
      _completedIds.remove(id);
    } else {
      _completedIds.add(id);
    }
    await prefs.saveCompletedChallenges(_completedIds);
    notifyListeners();
  }

  void registerShare(String id) {
    _shareCounts.update(id, (value) => value + 1, ifAbsent: () => 1);
    notifyListeners();
  }
}
