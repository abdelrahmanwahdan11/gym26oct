import 'package:get/get.dart';

import '../data/models/booking.dart';
import '../data/repositories/prefs_repository.dart';

class BookingController extends GetxController {
  BookingController(this._prefsRepository);

  final PrefsRepository _prefsRepository;
  final RxList<Booking> bookings = <Booking>[].obs;

  @override
  void onInit() {
    super.onInit();
    final saved = _prefsRepository.bookings
        .map((map) => Booking.fromMap(Map<String, dynamic>.from(map)))
        .toList();
    bookings.assignAll(saved);
  }

  Future<void> addBooking(Map<String, dynamic> payload) async {
    final booking = Booking(
      id: 'b${bookings.length + 1}',
      trainerId: payload['trainerId'] as String,
      gymId: payload['gymId'] as String,
      slot: payload['slot'] as String,
      status: payload['status'] as String? ?? 'pending',
    );
    bookings.add(booking);
    await _prefsRepository.saveBookings(bookings.map((e) => e.toMap()).toList());
  }
}
