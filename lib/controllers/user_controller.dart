import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:music_royalty/models/user.dart';

class UserController extends GetxController {
  late Userx userModel;
  var loading = true.obs;
  @override
  void onInit() async {
    await getUserDeatails();
    super.onInit();
  }

  Future getUserDeatails() async {
    loading.value = true;
    var res = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    userModel = Userx(
        middle_name: res["middle_name"],
        last_name: res["last_name"],
        email: res["email"],
        adress: res["adress"],
        state: res["state"],
        phone_number: res["num"],
        zip: res["zip"],
        Date: res["birth_date"],
        userId: res["userId"],
        first_name: res["first_name"]);
    loading.value = false;
  }

  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;
}
