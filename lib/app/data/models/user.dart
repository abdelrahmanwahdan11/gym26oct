class UserProfile {
  UserProfile({
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

  factory UserProfile.fromMap(Map<String, dynamic> map) => UserProfile(
        id: map['id'] as String,
        name: map['name'] as String,
        email: map['email'] as String? ?? '',
        avatar: map['avatar'] as String? ?? '',
        heightCm: (map['heightCm'] as num?)?.toDouble() ?? 0,
        weightKg: (map['weightKg'] as num?)?.toDouble() ?? 0,
        goal: map['goal'] as String? ?? '',
        level: map['level'] as String? ?? '',
        locale: map['locale'] as String? ?? 'ar',
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

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'avatar': avatar,
        'heightCm': heightCm,
        'weightKg': weightKg,
        'goal': goal,
        'level': level,
        'locale': locale,
      };
}
