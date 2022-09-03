import 'package:cloud_firestore/cloud_firestore.dart';
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
    return UserMusics(
      userId: data?['UserId'],
      MusicList: data?['MusicList'],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (userId != null) "UserId": userId,
      if (MusicList != null) "MusicList": FieldValue.arrayUnion(MusicList!)
    };
  }
}
