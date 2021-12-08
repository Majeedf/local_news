import 'package:cloud_firestore/cloud_firestore.dart';

class NewsModel
{
  String? documentId;
  late String title;
  late String description;
  late String url;
  late String userId;
  late String date;
  late String status;

  //NewsModel({required this.title,required this.description,required this.category});

  NewsModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    documentId = documentSnapshot.id;
    title = documentSnapshot["title"];
    description = documentSnapshot["desc"];
    url = documentSnapshot["url"];
    userId=documentSnapshot["userid"];
    date=documentSnapshot["createdon"];
    status=documentSnapshot["status"];
  }
}