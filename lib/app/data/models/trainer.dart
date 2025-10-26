class GymLocation {
  GymLocation({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.mapImage,
    required this.phone,
    required this.discountPercent,
  });

  factory GymLocation.fromMap(Map<String, dynamic> map) => GymLocation(
        id: map['id'] as String,
        name: map['name'] as String,
        address: map['address'] as String,
        city: map['city'] as String,
        mapImage: map['mapImage'] as String,
        phone: map['phone'] as String,
        discountPercent: (map['discountPercent'] as num).toInt(),
      );

  final String id;
  final String name;
  final String address;
  final String city;
  final String mapImage;
  final String phone;
  final int discountPercent;
}

class TrainerContact {
  TrainerContact({
    required this.phone,
    required this.whatsapp,
    required this.email,
  });

  factory TrainerContact.fromMap(Map<String, dynamic> map) => TrainerContact(
        phone: map['phone'] as String,
        whatsapp: map['whatsapp'] as String,
        email: map['email'] as String,
      );

  final String phone;
  final String whatsapp;
  final String email;
}

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

  factory Trainer.fromMap(Map<String, dynamic> map) => Trainer(
        id: map['id'] as String,
        name: map['name'] as String,
        avatar: map['avatar'] as String,
        bio: map['bio'] as String,
        rating: (map['rating'] as num).toDouble(),
        specialties: List<String>.from(map['specialties'] ?? const <String>[]),
        pricePerSession: (map['pricePerSession'] as num).toDouble(),
        gyms: (map['gyms'] as List<dynamic>)
            .map((e) => GymLocation.fromMap(Map<String, dynamic>.from(e as Map)))
            .toList(),
        contacts: TrainerContact.fromMap(
            Map<String, dynamic>.from(map['contacts'] as Map)),
        slots: List<String>.from(map['slots'] ?? const <String>[]),
      );

  final String id;
  final String name;
  final String avatar;
  final String bio;
  final double rating;
  final List<String> specialties;
  final double pricePerSession;
  final List<GymLocation> gyms;
  final TrainerContact contacts;
  final List<String> slots;
}
