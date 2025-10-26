import 'dart:async';

import '../models/trainer.dart';
import 'mock_seed.dart';

class TrainersRepository {
  TrainersRepository({this.pageSize = 12, this.delay = const Duration(milliseconds: 450)});

  final int pageSize;
  final Duration delay;
  final List<Map<String, dynamic>> _trainerMaps =
      List<Map<String, dynamic>>.from(mockSeed['trainers'] as List);

  Future<List<Trainer>> fetchTrainers(int page, {String query = ''}) async {
    await Future<void>.delayed(delay);
    final filtered = query.isEmpty
        ? _trainerMaps
        : _trainerMaps
            .where((map) =>
                (map['name'] as String).toLowerCase().contains(query.toLowerCase()))
            .toList();
    final start = page * pageSize;
    final end = (start + pageSize).clamp(0, filtered.length);
    if (start >= filtered.length) {
      return const [];
    }
    return filtered.sublist(start, end).map(Trainer.fromMap).toList();
  }

  Trainer? byId(String id) {
    final map = _trainerMaps.firstWhere(
      (element) => element['id'] == id,
      orElse: () => {},
    );
    if (map.isEmpty) return null;
    return Trainer.fromMap(map);
  }

  Future<Trainer> createTrainer(Map<String, dynamic> payload) async {
    await Future<void>.delayed(delay);
    final newTrainer = {
      'id': 't${_trainerMaps.length + 1}',
      ...payload,
      'rating': payload['rating'] ?? 4.5,
      'specialties': (payload['specialties'] as String?)
              ?.split(',')
              .map((e) => e.trim())
              .where((element) => element.isNotEmpty)
              .toList() ??
          <String>[],
      'gyms': payload['gyms'] ?? <Map<String, dynamic>>[],
      'pricePerSession':
          (payload['price'] as num?)?.toDouble() ?? 20.0,
      'contacts': payload['contacts'] ??
          {
            'phone': payload['phone'] ?? '',
            'whatsapp': payload['phone'] ?? '',
            'email': payload['email'] ?? '',
          },
      'slots': payload['slots'] ?? <String>[],
    };
    _trainerMaps.add(newTrainer);
    return Trainer.fromMap(newTrainer);
  }
}
