import 'dart:async';
import 'dart:math';

import '../models/models.dart';
import '../seed/mock_data.dart';

class ProgramsRepository {
  ProgramsRepository();

  Future<List<Program>> fetchPrograms({int page = 0, int pageSize = 12}) async {
    await Future.delayed(const Duration(milliseconds: 450));
    final start = page * pageSize;
    if (start >= mockPrograms.length) return [];
    final end = min(start + pageSize, mockPrograms.length);
    final slice = mockPrograms.sublist(start, end);
    return slice.map((e) => Program.fromJson(Map<String, dynamic>.from(e))).toList();
  }

  Future<Program?> findProgram(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final map = mockPrograms.cast<Map<String, dynamic>>().firstWhere(
          (element) => element['id'] == id,
          orElse: () => {},
        );
    if (map.isEmpty) return null;
    return Program.fromJson(map);
  }
}
