class Booking {
  Booking({
    required this.id,
    required this.trainerId,
    required this.gymId,
    required this.slot,
    required this.status,
  });

  factory Booking.fromMap(Map<String, dynamic> map) => Booking(
        id: map['id'] as String,
        trainerId: map['trainerId'] as String,
        gymId: map['gymId'] as String,
        slot: map['slot'] as String,
        status: map['status'] as String,
      );

  final String id;
  final String trainerId;
  final String gymId;
  final String slot;
  final String status;

  Map<String, dynamic> toMap() => {
        'id': id,
        'trainerId': trainerId,
        'gymId': gymId,
        'slot': slot,
        'status': status,
      };
}
