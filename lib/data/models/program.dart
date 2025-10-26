class Program {
  Program({
    required this.id,
    required this.title,
    required this.level,
    required this.weeks,
    required this.image,
    required this.desc,
    required this.coach,
    required this.durationMin,
    required this.setsPerWeek,
    required this.tags,
    required this.exercises,
  });

  factory Program.fromJson(Map<String, dynamic> json) => Program(
        id: json['id'] as String,
        title: json['title'] as String,
        level: json['level'] as String,
        weeks: json['weeks'] as int,
        image: json['image'] as String,
        desc: json['desc'] as String,
        coach: json['coach'] as String,
        durationMin: (json['durationMin'] as num).toInt(),
        setsPerWeek: (json['setsPerWeek'] as num).toInt(),
        tags: (json['tags'] as List).cast<String>(),
        exercises: (json['exercises'] as List).cast<String>(),
      );

  final String id;
  final String title;
  final String level;
  final int weeks;
  final String image;
  final String desc;
  final String coach;
  final int durationMin;
  final int setsPerWeek;
  final List<String> tags;
  final List<String> exercises;
}
