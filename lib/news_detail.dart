import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_news/news_model.dart';

class NewsDetails extends StatefulWidget {


  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {

  List<NewsModel> news=Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('News Detail'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            verticalDirection: VerticalDirection.up,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Image.network(news[0].url),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(news[0].date, style: TextStyle(color:Colors.grey.shade400,fontSize: 14.0),
                        ),
                      ],
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      news[0].title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      news[0].description,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
