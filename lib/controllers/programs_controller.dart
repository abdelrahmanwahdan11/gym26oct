import 'dart:async';

import 'package:flutter/material.dart';

import '../data/models/models.dart';
import '../data/repositories/prefs_repository.dart';
import '../data/repositories/program_repository.dart';

class ProgramsController extends ChangeNotifier {
  ProgramsController(this.repository, this.prefs);

  final ProgramsRepository repository;
  final PrefsRepository prefs;

  final List<Program> _programs = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _page = 0;
  String _query = '';
  String? _levelFilter;
  Timer? _debounce;
  Set<String> _favorites = {};

  List<Program> get programs {
    if (_query.isEmpty && _levelFilter == null) return List.unmodifiable(_programs);
    return _programs
        .where((program) {
          final matchesQuery = _query.isEmpty || program.title.toLowerCase().contains(_query.toLowerCase());
          final matchesLevel = _levelFilter == null || program.level == _levelFilter;
          return matchesQuery && matchesLevel;
        })
        .toList(growable: false);
  }

  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  String? get levelFilter => _levelFilter;
  Set<String> get favorites => _favorites;

  Future<void> bootstrap() async {
    _favorites = prefs.loadFavorites();
    await refresh();
  }

  Future<void> refresh() async {
    _page = 0;
    _hasMore = true;
    _programs.clear();
    await _fetchPage();
  }

  Future<void> loadMore() async {
    if (_isLoading || !_hasMore) return;
    _page += 1;
    await _fetchPage();
  }

  void setLevelFilter(String? level) {
    _levelFilter = level;
    notifyListeners();
  }

  void search(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () {
      _query = query;
      notifyListeners();
    });
  }

  Future<void> toggleFavorite(String id) async {
    if (_favorites.contains(id)) {
      _favorites.remove(id);
    } else {
      _favorites.add(id);
    }
    await prefs.saveFavorites(_favorites);
    notifyListeners();
  }

  Future<Program?> resolveProgram(String id) async {
    try {
      final existing = _programs.firstWhere((element) => element.id == id, orElse: () => throw StateError('not found'));
      return existing;
    } catch (_) {
      final fetched = await repository.findProgram(id);
      if (fetched != null) {
        if (_programs.every((element) => element.id != fetched.id)) {
          _programs.add(fetched);
          notifyListeners();
        }
      }
      return fetched;
    }
  }

  Future<void> _fetchPage() async {
    _isLoading = true;
    notifyListeners();
    final items = await repository.fetchPrograms(page: _page);
    if (items.isEmpty) {
      _hasMore = false;
    } else {
      _programs.addAll(items);
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
