import 'package:get/get.dart';

class StatsController extends GetxController {
  final RxMap<String, dynamic> monthly = <String, dynamic>{
    'volume': 432,
    'streak': 6,
    'hydration': 78,
  }.obs;

  final RxList<int> miniChart = <int>[12, 20, 18, 24, 32, 28].obs;

  void recordVolume(int value) {
    monthly['volume'] = value;
    monthly.refresh();
  }
}
