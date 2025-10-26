import 'package:get/get.dart';

class SearchController extends GetxController {
  final RxString query = ''.obs;

  void updateQuery(String value) {
    query.value = value;
  }
}
