class Exercise {
  Exercise({
    required this.id,
    required this.title,
    required this.image,
    required this.video,
    required this.durationSeconds,
    required this.reps,
    required this.sets,
    required this.restSeconds,
    required this.tips,
  });

  factory Exercise.fromMap(Map<String, dynamic> map) => Exercise(
        id: map['id'] as String,
        title: map['title'] as String,
        image: map['image'] as String,
        video: map['video'] as String? ?? '',
        durationSeconds: map['durationSec'] as int,
        reps: map['reps'] as int,
        sets: map['sets'] as int,
        restSeconds: map['restSec'] as int,
        tips: List<String>.from(map['tips'] ?? const <String>[]),
      );

  final String id;
  final String title;
  final String image;
  final String video;
  final int durationSeconds;
  final int reps;
  final int sets;
  final int restSeconds;
  final List<String> tips;
}
