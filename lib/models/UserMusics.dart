import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:music_royalty/Screens/main/music_steps/music_steps.dart';
import 'package:music_royalty/models/music.dart';

class UserMusics {
  String? userId;
  List<Music>? MusicList;
  UserMusics({this.userId, this.MusicList});
  factory UserMusics.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    List<Music> ss = <Music>[];
    for (var element in data?['MusicList']) {
      ss.add(Music(
          Title: element['Title'],
          updated_at: element['updated_at'],
          created_at: element['created_at'],
          currentStep: element['CurrentStep']));
    }

    return UserMusics(
      userId: data?['UserId'],
      MusicList: ss,
    );
  }
  Map<String, dynamic> toFirestore() {
    List strings = [];
    MusicList!.forEach((element) {
      strings.add(element.toFirestore());
    });
    return {
      if (userId != null) "UserId": userId,
      if (MusicList != null) "MusicList": strings
    };
  }
}
