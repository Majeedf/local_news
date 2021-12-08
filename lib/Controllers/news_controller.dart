import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:local_news/Constants/constant.dart';
import 'package:local_news/news_model.dart';
import 'package:local_news/firestore_db.dart';

class NewsController extends GetxController
{
  static NewsController instance = Get.find();
  late File file;
  Rx<List<NewsModel>> newsList = Rx<List<NewsModel>>([]);
  List<NewsModel> get news => newsList.value;

  Rx<List<NewsModel>> newNewsList = Rx<List<NewsModel>>([]);
  List<NewsModel> get newNews => newNewsList.value;


  @override
  void onReady() {
    newsList.bindStream(FirestoreDb.documentStream());
    newNewsList.bindStream(FirestoreDb.newNewsStream());
  }


  Future getFile()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions: ['jpg','png']);

    if (result != null) {
      // Uint8List fileBytes = result.files.first.bytes;
      file = File(result.files.single.path.toString());
     // fileName = result.files.first.name;
    }
  }

  Future addNews(String fileName,desc) async
  {
      EasyLoading.show();
      // Upload file
      DateTime now = DateTime.now();
      String convertedDateTime = "${now.day.toString()}/${now.month.toString()}/${now.year.toString()}";

      await FirebaseStorage.instance.ref('News/'+authController.firebaseUser.value!.uid+'/$fileName').putFile(file)
          .then((taskSnapshot) {
        if (taskSnapshot.state == TaskState.success) {
          FirebaseStorage.instance
              .ref('News/'+authController.firebaseUser.value!.uid+'/$fileName')
              .getDownloadURL()
              .then((url) {
            firebaseFirestore
                .collection('News')
                .add({
              'userid':auth.currentUser!.uid,
              'title': fileName,
              'desc':desc,
              'url':url,
              'createdon': convertedDateTime,
              'status': "new",
            });
          }).catchError((onError) {
            print("Got Error $onError");
            Get.snackbar(
              "Error",
              onError.toString(),
              snackPosition: SnackPosition.BOTTOM,
            );
          });
        }
      });
      EasyLoading.dismiss();
  }

  Future AuthorizeNews(String id) async
  {

    EasyLoading.show();
    await firebaseFirestore
        .collection('News')
        .doc(id)
        .update({
      'status':"approved",
     }
    );
    newNewsList.refresh();
    newsList.refresh();
    EasyLoading.dismiss();
  }
}