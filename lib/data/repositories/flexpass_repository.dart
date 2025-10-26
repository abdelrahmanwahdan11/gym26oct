import '../models/models.dart';
import '../seed/mock_data.dart';

class FlexPassRepository {
  Future<FlexPass> fetchFlexPass() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return FlexPass.fromJson(Map<String, dynamic>.from(mockFlexPass));
  }
}
