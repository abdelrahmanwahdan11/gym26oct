import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/models/models.dart';
import '../data/repositories/flexpass_repository.dart';
import '../data/repositories/prefs_repository.dart';

class FlexPassController extends GetxController {
  FlexPassController(this.repository, this.prefs);

  final FlexPassRepository repository;
  final PrefsRepository prefs;

  FlexPass? _flexPass;

  FlexPass? get flexPass => _flexPass;

  @override
  void onInit() {
    super.onInit();
    bootstrap();
  }

  Future<void> bootstrap() async {
    final cached = prefs.loadFlexPass();
    if (cached != null) {
      _flexPass = FlexPass.fromJson(cached);
    } else {
      await refresh();
    }
    update();
  }

  Future<void> refresh() async {
    _flexPass = await repository.fetchFlexPass();
    await prefs.saveFlexPass({
      'id': _flexPass!.id,
      'holderName': _flexPass!.holderName,
      'tier': _flexPass!.tier,
      'clubsAllowed': _flexPass!.clubsAllowed,
      'expiry': _flexPass!.expiry,
      'weeklySchedule': _flexPass!.weeklySchedule,
      'perks': _flexPass!.perks,
    });
    update();
  }
}
