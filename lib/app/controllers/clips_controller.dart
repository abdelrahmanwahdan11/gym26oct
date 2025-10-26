import 'package:get/get.dart';

import '../data/models/clip.dart';
import '../data/repositories/clips_repository.dart';

class ClipsController extends GetxController {
  ClipsController(this._repository);

  final ClipsRepository _repository;

  final RxList<WorkoutClip> clips = <WorkoutClip>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasMore = true.obs;
  final RxString query = ''.obs;
  int _page = 0;

  @override
  void onInit() {
    super.onInit();
    loadInitial();
  }

  Future<void> loadInitial() async {
    clips.clear();
    _page = 0;
    hasMore.value = true;
    await loadMore(reset: true);
  }

  Future<void> search(String value) async {
    query.value = value;
    await loadInitial();
  }

  Future<void> loadMore({bool reset = false}) async {
    if (!hasMore.value || isLoading.value) return;
    isLoading.value = true;
    final data = await _repository.fetchClips(reset ? 0 : _page, query: query.value);
    if (reset) {
      clips.assignAll(data);
      _page = 1;
      hasMore.value = data.length == _repository.pageSize;
    } else {
      if (data.isEmpty) {
        hasMore.value = false;
      } else {
        clips.addAll(data);
        _page++;
      }
    }
    isLoading.value = false;
  }
}
