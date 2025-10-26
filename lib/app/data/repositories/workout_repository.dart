import 'dart:async';

import '../models/exercise.dart';
import 'mock_seed.dart';

class WorkoutRepository {
  WorkoutRepository({this.delay = const Duration(milliseconds: 250)});

  final Duration delay;

  Future<List<Exercise>> loadSessionExercises(List<String> ids) async {
    await Future<void>.delayed(delay);
    final map = {
      for (final raw in mockSeed['exercises'] as List)
        (raw['id'] as String): Map<String, dynamic>.from(raw as Map)
    };
    return ids.map((id) => Exercise.fromMap(map[id]!)).toList();
  }
}
