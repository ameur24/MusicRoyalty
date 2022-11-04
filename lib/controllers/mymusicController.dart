import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart';

import '../models/UserMusics.dart';
import '../models/music.dart';

class MyMusicController extends GetxController {
  List<Music> mymusicList = [];
  var loadingMusicLIst = true.obs;
  var musiccurrentstep = 0.obs;
  Future<void> getmymusic() async {
    mymusicList = [];
    loadingMusicLIst.value = true;
    final MusicCollection = await FirebaseFirestore.instance
        .collection('Music')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('MusicList');

    // Get docs from collection reference
    QuerySnapshot querySnapshot = await MusicCollection.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc).toList();

    print(allData[0]['Title'].toString());
    print(allData[0]['id'].toString());
    for (var index = 0; index < allData.length; index++) {
      mymusicList.add(Music(
        currentStep: allData[index]['CurrentStep'],
        Title: allData[index]['Title'],
        created_at: allData[index]['created_at'],
        updated_at: allData[index]['updated_at'],
        id: allData[index]['id'],
      ));
    }

    loadingMusicLIst.value = false;
  }

  @override
  void onInit() async {
    await getmymusic();
    super.onInit();
  }
}
