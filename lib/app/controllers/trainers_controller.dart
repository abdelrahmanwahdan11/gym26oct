import 'package:get/get.dart';

import '../data/models/trainer.dart';
import '../data/repositories/trainers_repository.dart';

class TrainersController extends GetxController {
  TrainersController(this._repository);

  final TrainersRepository _repository;

  final RxList<Trainer> trainers = <Trainer>[].obs;
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
    trainers.clear();
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
    final data =
        await _repository.fetchTrainers(reset ? 0 : _page, query: query.value);
    if (reset) {
      trainers.assignAll(data);
      _page = 1;
      hasMore.value = data.length == _repository.pageSize;
    } else {
      if (data.isEmpty) {
        hasMore.value = false;
      } else {
        trainers.addAll(data);
        _page++;
      }
    }
    isLoading.value = false;
  }

  Trainer? findById(String id) => _repository.byId(id);

  Future<Trainer> createTrainer(Map<String, dynamic> payload) async {
    final trainer = await _repository.createTrainer(payload);
    trainers.insert(0, trainer);
    return trainer;
  }
}
