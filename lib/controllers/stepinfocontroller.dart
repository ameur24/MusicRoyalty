import 'package:get/get.dart';

class stepinfocontroller extends GetxController {
  var selectedSite = 0.obs;
  setselectedSite(value) => selectedSite.value = value;
  @override
  void onInit() {
    setselectedSite(0);
    super.onInit();
  }

  @override
  void onReady() {
    setselectedSite(0);
    super.onReady();
  }

  @override
  void onClose() {
    setselectedSite(0);
    super.onClose();
  }
}
