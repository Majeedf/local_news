import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_news/Controllers/auth_controller.dart';
import 'package:local_news/Controllers/news_controller.dart';
import 'package:local_news/add_news.dart';
import 'package:local_news/login.dart';
import 'package:local_news/news_detail.dart';

import 'Constants/constant.dart';

class AuthorizeArticle extends StatefulWidget
{
  const AuthorizeArticle({Key? key}) : super(key: key);

  @override
  State<AuthorizeArticle> createState() => _AuthorizeArticleState();
}

class _AuthorizeArticleState extends State<AuthorizeArticle>
{
  AuthController controller=Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(title:const Text('Authorize',),
            centerTitle: true,
          ),
          body:GetX<NewsController>(
            init: Get.put<NewsController>(NewsController()),
            builder: (NewsController controller)
            {
              return controller.newNews.length>0?
              ListView.builder(
                  itemCount: controller.newNews.length,
                  itemBuilder:(BuildContext context,int index)
                  {
                    return Padding(
                        padding: EdgeInsets.all(5),
                        child:InkWell(
                          onTap:(){
                            Get.to(NewsDetails(),arguments: [controller.newNews[index]]);
                          },
                          child:Column(
                            children: [
                              Stack(
                                alignment: Alignment.bottomLeft,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(
                                      controller.newNews[index].url,
                                      width: double.infinity,
                                      height: 300,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                                    child:Container(
                                      color: Colors.black.withOpacity(0.5),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          Text(controller.newNews[index].title,
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),),
                                          SizedBox(height: 10,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text(controller.newNews[index].date,
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.grey.shade200,),)
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(50, 8, 50, 8)),
                                    elevation: MaterialStateProperty.all(1),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                    backgroundColor: MaterialStateProperty.all(Colors.red.shade600),
                                    //shadowColor: MaterialStateProperty.all(Theme.of(context).colorScheme.onSurface)
                                  ),
                                  onPressed: (){
                                    controller.AuthorizeNews(controller.newNews[index].documentId.toString());
                                  },
                                  child: Text('Authorize')),
                            ],
                          )
                        )
                    );
                  }
              )
                  :Center(child: Text('No news to authorize!',style: TextStyle(color: Colors.grey.shade300),),);
            },
          ),
        );
  }
}