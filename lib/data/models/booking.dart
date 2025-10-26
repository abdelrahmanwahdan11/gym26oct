class Booking {
  Booking({
    required this.id,
    required this.trainerId,
    required this.gymId,
    required this.slot,
    required this.status,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json['id'] as String,
        trainerId: json['trainerId'] as String,
        gymId: json['gymId'] as String,
        slot: json['slot'] as String,
        status: json['status'] as String,
      );

  final String id;
  final String trainerId;
  final String gymId;
  final String slot;
  final String status;
}
