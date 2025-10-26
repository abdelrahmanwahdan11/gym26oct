import 'dart:async';
import 'dart:math';

import '../models/models.dart';
import '../seed/mock_data.dart';

class TrainersRepository {
  Future<List<Trainer>> fetchTrainers({int page = 0, int pageSize = 12}) async {
    await Future.delayed(const Duration(milliseconds: 450));
    final start = page * pageSize;
    if (start >= mockTrainers.length) return [];
    final end = min(start + pageSize, mockTrainers.length);
    final slice = mockTrainers.sublist(start, end);
    return slice.map((e) => Trainer.fromJson(Map<String, dynamic>.from(e))).toList();
  }

  Future<Trainer?> findTrainer(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final map = mockTrainers.cast<Map<String, dynamic>>().firstWhere(
          (element) => element['id'] == id,
          orElse: () => {},
        );
    if (map.isEmpty) return null;
    return Trainer.fromJson(map);
  }

  Future<Trainer> createTrainer(Map<String, dynamic> payload) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final newTrainer = {
      'id': 't${mockTrainers.length + 1}',
      'name': payload['name'] ?? 'Trainer',
      'avatar': 'https://i.pravatar.cc/150?img=52',
      'bio': payload['bio'] ?? '',
      'rating': 4.6,
      'specialties': (payload['specialties'] as String?)
              ?.split(',')
              .map((e) => e.trim())
              .where((element) => element.isNotEmpty)
              .toList() ??
          [],
      'pricePerSession': double.tryParse(payload['price']?.toString() ?? '0') ?? 0,
      'gyms': [
        {
          'id': 'g-new',
          'name': 'Community Gym',
          'address': 'City Center',
          'city': 'City',
          'mapImage': 'https://images.unsplash.com/photo-1554284126-aa88f22d8b74',
          'phone': payload['contacts'] ?? '',
          'discountPercent': 10,
        }
      ],
      'contacts': {
        'phone': payload['contacts'] ?? '',
        'whatsapp': payload['contacts'] ?? '',
        'email': 'contact@athletica.app',
      },
      'slots': ['2025-12-01 17:00'],
    };
    mockTrainers.add(newTrainer);
    return Trainer.fromJson(newTrainer);
  }
}
