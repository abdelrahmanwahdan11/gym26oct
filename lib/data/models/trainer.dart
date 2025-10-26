import 'gym.dart';

class Trainer {
  Trainer({
    required this.id,
    required this.name,
    required this.avatar,
    required this.bio,
    required this.rating,
    required this.specialties,
    required this.pricePerSession,
    required this.gyms,
    required this.contacts,
    required this.slots,
  });

  factory Trainer.fromJson(Map<String, dynamic> json) => Trainer(
        id: json['id'] as String,
        name: json['name'] as String,
        avatar: json['avatar'] as String,
        bio: json['bio'] as String,
        rating: (json['rating'] as num).toDouble(),
        specialties: (json['specialties'] as List).cast<String>(),
        pricePerSession: (json['pricePerSession'] as num).toDouble(),
        gyms: (json['gyms'] as List).map((e) => Gym.fromJson(Map<String, dynamic>.from(e))).toList(),
        contacts: Map<String, dynamic>.from(json['contacts'] as Map),
        slots: (json['slots'] as List).cast<String>(),
      );

  final String id;
  final String name;
  final String avatar;
  final String bio;
  final double rating;
  final List<String> specialties;
  final double pricePerSession;
  final List<Gym> gyms;
  final Map<String, dynamic> contacts;
  final List<String> slots;
}
