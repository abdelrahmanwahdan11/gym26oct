class FlexPass {
  FlexPass({
    required this.id,
    required this.holderName,
    required this.tier,
    required this.clubsAllowed,
    required this.expiry,
    required this.weeklySchedule,
    required this.perks,
  });

  factory FlexPass.fromJson(Map<String, dynamic> json) => FlexPass(
        id: json['id'] as String,
        holderName: json['holderName'] as String,
        tier: json['tier'] as String,
        clubsAllowed: (json['clubsAllowed'] as num).toInt(),
        expiry: json['expiry'] as String,
        weeklySchedule: (json['weeklySchedule'] as List)
            .map((e) => Map<String, String>.from(e as Map))
            .toList(),
        perks: (json['perks'] as List).cast<String>(),
      );

  final String id;
  final String holderName;
  final String tier;
  final int clubsAllowed;
  final String expiry;
  final List<Map<String, String>> weeklySchedule;
  final List<String> perks;
}
