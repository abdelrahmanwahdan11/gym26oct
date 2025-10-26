import 'dart:async';

import '../models/clip.dart';
import 'mock_seed.dart';

class ClipsRepository {
  ClipsRepository({this.pageSize = 12, this.delay = const Duration(milliseconds: 450)});

  final int pageSize;
  final Duration delay;
  final List<Map<String, dynamic>> _clipMaps =
      List<Map<String, dynamic>>.from(mockSeed['clips'] as List);

  Future<List<WorkoutClip>> fetchClips(int page, {String query = ''}) async {
    await Future<void>.delayed(delay);
    final filtered = query.isEmpty
        ? _clipMaps
        : _clipMaps
            .where((map) =>
                (map['title'] as String).toLowerCase().contains(query.toLowerCase()))
            .toList();
    final start = page * pageSize;
    final end = (start + pageSize).clamp(0, filtered.length);
    if (start >= filtered.length) {
      return const [];
    }
    return filtered.sublist(start, end).map(WorkoutClip.fromMap).toList();
  }
}
