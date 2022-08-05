import 'package:cloud_firestore/cloud_firestore.dart';

class Music {
  int? currentStep;
  String? Title, ISRC, ISWC, UPC;
  List<String>? Songwriters;
  Timestamp? created_at;
  Timestamp? updated_at = Timestamp.now();

  String? userId;
  Music(
      {this.Title,
      this.updated_at,
      this.ISRC,
      this.currentStep,
      this.userId,
      this.ISWC,
      this.UPC,
      this.Songwriters,
      this.created_at});
  factory Music.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return Music(
      Title: data?['Title'],
      currentStep: data?['currentStep'],
      ISRC: data?['ISRC'],
      ISWC: data?['ISWC'],
      UPC: data?['UPC'],
      created_at: data?["created_at"],
      updated_at: data?["updated_at"],
      Songwriters: data?['Songwriters'] is Iterable
          ? List.from(data?['Songwriters'])
          : null,
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (created_at != null) "created_at": created_at,
      if (updated_at != null) "updated_at": updated_at,
      if (Title != null) "Title": Title,
      if (currentStep != null) "CurrentStep": currentStep,
      if (ISRC != null) "ISRC": ISRC,
      if (userId != null) "userId": userId,
      if (ISWC != null) "ISWC": ISWC,
      if (UPC != null) "UPC": UPC,
      if (Songwriters != null) "Songwriters": Songwriters
    };
  }
}
