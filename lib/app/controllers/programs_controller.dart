import 'package:get/get.dart';

import '../data/models/exercise.dart';
import '../data/models/program.dart';
import '../data/repositories/programs_repository.dart';

class ProgramsController extends GetxController {
  ProgramsController(this._repository);

  final ProgramsRepository _repository;

  final List<Program> _allPrograms = <Program>[];
  final RxList<Program> programs = <Program>[].obs;
  final RxList<Exercise> warmups = <Exercise>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasMore = true.obs;
  final RxString query = ''.obs;
  int _page = 0;

  @override
  void onInit() {
    super.onInit();
    loadInitial();
    warmups.assignAll(_repository.warmups());
  }

  Future<void> loadInitial() async {
    programs.clear();
    _allPrograms.clear();
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
      _allPrograms.addAll(data);
      _applyFilter();
      _page++;
      if (data.length < _repository.pageSize) {
        hasMore.value = false;
      }
    }
    isLoading.value = false;
  }

  void filter(String value) {
    query.value = value;
    _applyFilter();
  }

  void _applyFilter() {
    if (query.value.isEmpty) {
      programs.assignAll(_allPrograms);
    } else {
      final lower = query.value.toLowerCase();
      programs.assignAll(
        _allPrograms.where(
          (program) => program.title.toLowerCase().contains(lower) ||
              program.tags.any((tag) => tag.toLowerCase().contains(lower)) ||
              program.coach.toLowerCase().contains(lower),
        ),
      );
    }
  }
}
