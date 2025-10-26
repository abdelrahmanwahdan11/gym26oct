import 'dart:async';

import '../models/program.dart';
import '../models/exercise.dart';
import 'mock_seed.dart';

class ProgramsRepository {
  ProgramsRepository({this.pageSize = 12, this.delay = const Duration(milliseconds: 450)});

  final int pageSize;
  final Duration delay;

  final List<Map<String, dynamic>> _programMaps =
      List<Map<String, dynamic>>.from(mockSeed['programs'] as List);
  final Map<String, Map<String, dynamic>> _exercisesMap = {
    for (final raw in mockSeed['exercises'] as List)
      (raw['id'] as String): Map<String, dynamic>.from(raw as Map)
  };

  Future<List<Program>> fetchPrograms(int page) async {
    await Future<void>.delayed(delay);
    final start = page * pageSize;
    final end = (start + pageSize).clamp(0, _programMaps.length);
    if (start >= _programMaps.length) {
      return const [];
    }
    return _programMaps.sublist(start, end).map(Program.fromMap).toList();
  }

  List<Exercise> warmups() {
    final ids = ['e1', 'e2', 'e3', 'e4'];
    return ids
        .map((id) => Exercise.fromMap(_exercisesMap[id]!))
        .toList(growable: false);
  }

  Exercise? byId(String id) {
    final map = _exercisesMap[id];
    if (map == null) return null;
    return Exercise.fromMap(map);
  }
}
