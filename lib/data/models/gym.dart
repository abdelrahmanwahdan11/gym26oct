class Gym {
  Gym({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.mapImage,
    required this.phone,
    required this.discountPercent,
  });

  factory Gym.fromJson(Map<String, dynamic> json) => Gym(
        id: json['id'] as String,
        name: json['name'] as String,
        address: json['address'] as String,
        city: json['city'] as String,
        mapImage: json['mapImage'] as String,
        phone: json['phone'] as String,
        discountPercent: (json['discountPercent'] as num).toInt(),
      );

  final String id;
  final String name;
  final String address;
  final String city;
  final String mapImage;
  final String phone;
  final int discountPercent;
}
