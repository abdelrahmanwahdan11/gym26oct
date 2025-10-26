class Program {
  Program({
    required this.id,
    required this.title,
    required this.level,
    required this.weeks,
    required this.image,
    required this.description,
    required this.coach,
    required this.durationMinutes,
    required this.setsPerWeek,
    required this.tags,
    required this.exercises,
  });

  factory Program.fromMap(Map<String, dynamic> map) => Program(
        id: map['id'] as String,
        title: map['title'] as String,
        level: map['level'] as String,
        weeks: map['weeks'] as int,
        image: map['image'] as String,
        description: map['desc'] as String,
        coach: map['coach'] as String,
        durationMinutes: map['durationMin'] as int,
        setsPerWeek: map['setsPerWeek'] as int,
        tags: List<String>.from(map['tags'] ?? const <String>[]),
        exercises: List<String>.from(map['exercises'] ?? const <String>[]),
      );

  final String id;
  final String title;
  final String level;
  final int weeks;
  final String image;
  final String description;
  final String coach;
  final int durationMinutes;
  final int setsPerWeek;
  final List<String> tags;
  final List<String> exercises;
}
