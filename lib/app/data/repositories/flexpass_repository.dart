import 'dart:async';

import '../models/flex_pass.dart';
import 'mock_seed.dart';

class FlexPassRepository {
  FlexPassRepository({this.delay = const Duration(milliseconds: 450)});

  final Duration delay;

  Future<FlexPass> fetchFlexPass() async {
    await Future<void>.delayed(delay);
    return FlexPass.fromMap(Map<String, dynamic>.from(mockSeed['flexpass'] as Map));
  }
}
