import 'package:get/get.dart';

import '../models/music.dart';

class Mymusicstepscontroller extends GetxController {
  final Music music;
  Mymusicstepscontroller({required this.music});
  var musiccurrentstep = 0.obs;

  @override
  void onInit() {
    musiccurrentstep.value = music.currentStep!;
    print(music.currentStep);
    print(musiccurrentstep.value);
    super.onInit();
  }
}
