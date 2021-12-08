import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_news/Controllers/auth_controller.dart';
import 'package:local_news/Controllers/news_controller.dart';
import 'package:local_news/add_news.dart';
import 'package:local_news/authorize_articles.dart';
import 'package:local_news/login.dart';
import 'package:local_news/news_detail.dart';

import 'Constants/constant.dart';

class Home extends StatefulWidget
{
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>
{
  AuthController controller=Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          appBar: AppBar(title:const Text('Local News',),
           centerTitle: true,),
          drawer:Drawer(
            child:ListView(
              padding: EdgeInsets.zero,
              children: [
                 DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                  child:Align(
                    alignment: Alignment.bottomLeft,
                    child:auth.currentUser!=null?Text(auth.currentUser!.email.toString()):Container(),
                  ),
                ),
                ListTile(
                  title: auth.currentUser!=null ?Text('Logout'):Text('Login'),
                  onTap: () {
                    if(auth.currentUser!=null)
                      {
                        authController.signOut();
                      }
                    else
                      {
                        Get.back();
                        Get.to(()=>Login());
                      }
                  },
                ),
                ListTile(
                  title: auth.currentUser!=null?Text('Add News'):Container(),
                  onTap: () {
                    if(auth.currentUser!=null)
                      {
                        Get.back();
                        Get.to(AddNews());
                      }
                  },
                ),
                ListTile(
                  title: auth.currentUser!=null && auth.currentUser!.email=='majeedfaiza94@gmail.com'?Text('Authorize Articles'):Container(),
                  onTap: () {
                    Get.back();
                    Get.to(AuthorizeArticle());
                  },
                ),
              ],
            ),
          ),
          body:GetX<NewsController>(
                init: Get.put<NewsController>(NewsController()),
                builder: (NewsController controller)
                {
                  return controller.news.length>0?
                  ListView.builder(
                      itemCount: controller.news.length,
                      itemBuilder:(BuildContext context,int index)
                      {
                        return Padding(
                          padding: EdgeInsets.all(5),
                          child:InkWell(
                            onTap:(){
                              Get.to(NewsDetails(),arguments: [controller.news[index]]);
                            },
                            child:Stack(
                              alignment: Alignment.bottomLeft,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    controller.news[index].url,
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
                                        Text(controller.news[index].title,
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),),
                                        SizedBox(height: 10,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(controller.news[index].date,
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.grey.shade200,),)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )

                              ],
                            ),
                          )
                        );
                      }
                  )
                  :Center(child: Text('no news have been added yet!',style: TextStyle(color: Colors.grey.shade300),),);
                },
              ),
        );
  }


}