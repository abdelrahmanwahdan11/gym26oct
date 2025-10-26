import 'package:flutter/material.dart';

import '../data/models/models.dart';
import '../data/repositories/prefs_repository.dart';
import '../data/repositories/trainers_repository.dart';

class TrainersController extends ChangeNotifier {
  TrainersController(this.repository, this.prefs);

  final TrainersRepository repository;
  final PrefsRepository prefs;

  final List<Trainer> _trainers = [];
  final List<Map<String, dynamic>> _bookings = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _page = 0;
  String _query = '';
  String _segment = 'Trainers';

  List<Trainer> get trainers {
    final filtered = _trainers.where((trainer) {
      if (_query.isEmpty) return true;
      return trainer.name.toLowerCase().contains(_query.toLowerCase()) ||
          trainer.specialties.any((element) => element.toLowerCase().contains(_query.toLowerCase()));
    }).toList();
    return filtered;
  }

  List<Map<String, dynamic>> get bookings => List.unmodifiable(_bookings);
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  String get segment => _segment;

  Future<void> bootstrap() async {
    _bookings.addAll(prefs.loadBookings());
    await refresh();
  }

  Future<void> refresh() async {
    _page = 0;
    _hasMore = true;
    _trainers.clear();
    await _fetch();
  }

  Future<void> loadMore() async {
    if (_isLoading || !_hasMore) return;
    _page += 1;
    await _fetch();
  }

  Future<void> _fetch() async {
    _isLoading = true;
    notifyListeners();
    final items = await repository.fetchTrainers(page: _page);
    if (items.isEmpty) {
      _hasMore = false;
    } else {
      _trainers.addAll(items);
    }
    _isLoading = false;
    notifyListeners();
  }

  void search(String query) {
    _query = query;
    notifyListeners();
  }

  void setSegment(String segment) {
    _segment = segment;
    notifyListeners();
  }

  Future<void> createTrainer(Map<String, dynamic> payload) async {
    final trainer = await repository.createTrainer(payload);
    _trainers.insert(0, trainer);
    notifyListeners();
  }

  Future<void> addBooking(Map<String, dynamic> booking) async {
    _bookings.add(booking);
    await prefs.saveBookings(_bookings);
    notifyListeners();
  }

  Future<Trainer?> resolveTrainer(String id) async {
    try {
      return _trainers.firstWhere((element) => element.id == id, orElse: () => throw StateError('not found'));
    } catch (_) {
      final fetched = await repository.findTrainer(id);
      if (fetched != null && _trainers.every((element) => element.id != fetched.id)) {
        _trainers.add(fetched);
        notifyListeners();
      }
      return fetched;
    }
  }
}
