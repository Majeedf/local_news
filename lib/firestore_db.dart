import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:local_news/news_model.dart';
import 'Constants/constant.dart';

class FirestoreDb
{
  //late File file;
  static Stream<List<NewsModel>> documentStream() {
   // EasyLoading.show();
     return firebaseFirestore
        .collection('News')
        .snapshots()
        .map((QuerySnapshot query) {
      List<NewsModel> todos = [];
      for (var todo in query.docs) {
        final documentModel =
        NewsModel.fromDocumentSnapshot(documentSnapshot: todo);
        if(documentModel.status=="approved")
          {
            todos.add(documentModel);
          }
       // EasyLoading.dismiss();
      }
      return todos;
    });

  }
  static Stream<List<NewsModel>> newNewsStream() {
    // EasyLoading.show();
    return firebaseFirestore
        .collection('News')
        .snapshots()
        .map((QuerySnapshot query) {
      List<NewsModel> todos = [];
      for (var todo in query.docs) {
        final documentModel =
        NewsModel.fromDocumentSnapshot(documentSnapshot: todo);
        if(documentModel.status=="new")
        {
          todos.add(documentModel);
        }
        // EasyLoading.dismiss();
      }
      return todos;
    });

  }
}