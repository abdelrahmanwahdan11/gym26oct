import 'package:get/get.dart';

import '../data/models/exercise.dart';
import '../data/models/program.dart';
import '../data/repositories/programs_repository.dart';

class ProgramsController extends GetxController {
  ProgramsController(this._repository);

  final ProgramsRepository _repository;

  final RxList<Program> programs = <Program>[].obs;
  final RxList<Exercise> warmups = <Exercise>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasMore = true.obs;
  int _page = 0;

  @override
  void onInit() {
    super.onInit();
    loadInitial();
    warmups.assignAll(_repository.warmups());
  }

  Future<void> loadInitial() async {
    programs.clear();
    _page = 0;
    hasMore.value = true;
    await loadMore();
  }

  Future<void> loadMore() async {
    if (!hasMore.value || isLoading.value) return;
    isLoading.value = true;
    final data = await _repository.fetchPrograms(_page);
    if (data.isEmpty) {
      hasMore.value = false;
    } else {
      programs.addAll(data);
      _page++;
    }
    isLoading.value = false;
  }
}
