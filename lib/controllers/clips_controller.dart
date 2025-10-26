import 'dart:async';

import 'package:flutter/material.dart';

import '../data/models/models.dart';
import '../data/repositories/clip_repository.dart';

class ClipsController extends ChangeNotifier {
  ClipsController(this.repository);

  final ClipsRepository repository;

  final List<ClipItem> _clips = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _page = 0;
  String _query = '';
  Timer? _debounce;

  List<ClipItem> get clips {
    if (_query.isEmpty) return List.unmodifiable(_clips);
    return _clips
        .where((clip) =>
            clip.title.toLowerCase().contains(_query.toLowerCase()) || clip.coach.toLowerCase().contains(_query.toLowerCase()))
        .toList(growable: false);
  }

  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> bootstrap() async {
    await refresh();
  }

  Future<void> refresh() async {
    _page = 0;
    _hasMore = true;
    _clips.clear();
    await _fetch();
  }

  Future<void> loadMore() async {
    if (_isLoading || !_hasMore) return;
    _page += 1;
    await _fetch();
  }

  void search(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () {
      _query = query;
      notifyListeners();
    });
  }

  Future<void> _fetch() async {
    _isLoading = true;
    notifyListeners();
    final items = await repository.fetchClips(page: _page);
    if (items.isEmpty) {
      _hasMore = false;
    } else {
      _clips.addAll(items);
    }
    _isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
