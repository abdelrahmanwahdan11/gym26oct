class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
    required this.heightCm,
    required this.weightKg,
    required this.goal,
    required this.level,
    required this.locale,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
        avatar: json['avatar'] as String,
        heightCm: (json['heightCm'] as num).toDouble(),
        weightKg: (json['weightKg'] as num).toDouble(),
        goal: json['goal'] as String,
        level: json['level'] as String,
        locale: json['locale'] as String,
      );

  final String id;
  final String name;
  final String email;
  final String avatar;
  final double heightCm;
  final double weightKg;
  final String goal;
  final String level;
  final String locale;
}
