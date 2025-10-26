class ClipItem {
  ClipItem({
    required this.id,
    required this.title,
    required this.thumb,
    required this.durationSec,
    required this.coach,
  });

  factory ClipItem.fromJson(Map<String, dynamic> json) => ClipItem(
        id: json['id'] as String,
        title: json['title'] as String,
        thumb: json['thumb'] as String,
        durationSec: (json['durationSec'] as num).toInt(),
        coach: json['coach'] as String,
      );

  final String id;
  final String title;
  final String thumb;
  final int durationSec;
  final String coach;
}
