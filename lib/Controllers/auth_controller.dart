import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:local_news/Constants/constant.dart';
import '../home.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> firebaseUser;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
  }

  void register(String email, password, name) async {
    try {
      EasyLoading.show();
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
     // auth.currentUser!.updateDisplayName('displayName');
      final CollectionReference userReference=firebaseFirestore.collection('Users');
      userReference.doc(firebaseUser.value!.uid).set({
        'name':name,
        'email':email,
      });
      EasyLoading.dismiss();
      Get.to(Home());
    } catch (firebaseAuthException) {
      Get.snackbar(
        "Error",
        firebaseAuthException.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    EasyLoading.dismiss();
  }

  void login(String email, password) async {
    EasyLoading.show();
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      firebaseUser.bindStream(auth.userChanges());
      Get.to(Home());
    } catch (firebaseAuthException) {
      Get.snackbar(
        "Error",
        firebaseAuthException.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    EasyLoading.dismiss();
  }

  void signOut() async {
    await auth.signOut();
    Get.offAll(()=>Home());
  }

  /*Future getPdfAndUpload()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions: ['pdf']);

    if (result != null) {
     // Uint8List fileBytes = result.files.first.bytes;
      File file = File(result.files.single.path.toString());
      String fileName = result.files.first.name;

      // Upload file
      await FirebaseStorage.instance.ref('uploads/$fileName').putFile(file);
    }
  }*/
}
