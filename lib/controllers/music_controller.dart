import 'package:get/get.dart';

class MusicController extends GetxController {
  var selectedSite = 0.obs;
  set SelctSite(value) => selectedSite.value = value;
  get obj => this.selectedSite.value;
}
