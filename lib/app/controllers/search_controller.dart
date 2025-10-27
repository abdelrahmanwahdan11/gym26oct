import 'package:get/get.dart';

import 'programs_controller.dart';

class SearchController extends GetxController {
  SearchController(this._programsController);

  final ProgramsController _programsController;
  final RxString query = ''.obs;

  void updateQuery(String value) {
    query.value = value;
    _programsController.filter(value);
  }

  void clear() {
    updateQuery('');
  }
}
