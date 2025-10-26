class Exercise {
  Exercise({
    required this.id,
    required this.title,
    required this.image,
    required this.video,
    required this.durationSec,
    required this.reps,
    required this.sets,
    required this.restSec,
    required this.tips,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        id: json['id'] as String,
        title: json['title'] as String,
        image: json['image'] as String,
        video: json['video'] as String,
        durationSec: (json['durationSec'] as num).toInt(),
        reps: (json['reps'] as num).toInt(),
        sets: (json['sets'] as num).toInt(),
        restSec: (json['restSec'] as num).toInt(),
        tips: (json['tips'] as List).cast<String>(),
      );

  final String id;
  final String title;
  final String image;
  final String video;
  final int durationSec;
  final int reps;
  final int sets;
  final int restSec;
  final List<String> tips;
}
