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

  factory FlexPass.fromMap(Map<String, dynamic> map) => FlexPass(
        id: map['id'] as String,
        holderName: map['holderName'] as String,
        tier: map['tier'] as String,
        clubsAllowed: map['clubsAllowed'] as int,
        expiry: map['expiry'] as String,
        weeklySchedule: List<Map<String, dynamic>>.from(
            map['weeklySchedule'] ?? const <Map<String, dynamic>>[]),
        perks: List<String>.from(map['perks'] ?? const <String>[]),
      );

  final String id;
  final String holderName;
  final String tier;
  final int clubsAllowed;
  final String expiry;
  final List<Map<String, dynamic>> weeklySchedule;
  final List<String> perks;
}
