import 'dart:async';
import 'dart:math';

import '../models/models.dart';
import '../seed/mock_data.dart';

class ClipsRepository {
  Future<List<ClipItem>> fetchClips({int page = 0, int pageSize = 12}) async {
    await Future.delayed(const Duration(milliseconds: 450));
    final start = page * pageSize;
    if (start >= mockClips.length) return [];
    final end = min(start + pageSize, mockClips.length);
    final slice = mockClips.sublist(start, end);
    return slice.map((e) => ClipItem.fromJson(Map<String, dynamic>.from(e))).toList();
  }
}
