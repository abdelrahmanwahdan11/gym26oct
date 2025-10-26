class WorkoutClip {
  WorkoutClip({
    required this.id,
    required this.title,
    required this.thumb,
    required this.durationSeconds,
    required this.coach,
  });

  factory WorkoutClip.fromMap(Map<String, dynamic> map) => WorkoutClip(
        id: map['id'] as String,
        title: map['title'] as String,
        thumb: map['thumb'] as String,
        durationSeconds: map['durationSec'] as int,
        coach: map['coach'] as String,
      );

  final String id;
  final String title;
  final String thumb;
  final int durationSeconds;
  final String coach;
}
