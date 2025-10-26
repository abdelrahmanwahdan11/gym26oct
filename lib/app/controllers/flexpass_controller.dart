import 'package:get/get.dart';

import '../data/models/flex_pass.dart';
import '../data/repositories/flexpass_repository.dart';

class FlexPassController extends GetxController {
  FlexPassController(this._repository);

  final FlexPassRepository _repository;

  final Rxn<FlexPass> flexPass = Rxn<FlexPass>();
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    if (isLoading.value) return;
    isLoading.value = true;
    flexPass.value = await _repository.fetchFlexPass();
    isLoading.value = false;
  }
}
