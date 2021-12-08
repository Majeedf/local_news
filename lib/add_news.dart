import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_news/Controllers/news_controller.dart';

class AddNews extends StatefulWidget
{
  const AddNews({Key?key}):super(key: key);

  State<AddNews> createState()=> _AddNewsState();
}

class _AddNewsState extends State<AddNews>
{
  NewsController _newsController=NewsController();
  final TextEditingController titleController=TextEditingController();
  final TextEditingController descController=TextEditingController();
  late File _file;
  String dropdownvalue = 'Article';
  var options =  ['Article','Story','Report','Other'];


  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Add News'),),),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top:30),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 35, right: 35),
                child: Column(
                  children: [
                    TextField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: "Title",
                          hintStyle:TextStyle(color: Colors.grey.shade500) ,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      controller: titleController,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.multiline,
                      maxLines: 10,
                      minLines: 3,
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: "Detail",
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      controller: descController,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(1),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                          backgroundColor: MaterialStateProperty.all(Colors.red.shade600),
                          //shadowColor: MaterialStateProperty.all(Theme.of(context).colorScheme.onSurface)
                        ),
                    onPressed: ()  {
                      _newsController.getFile();
                     },
                     child: Text('Choose Photo ')),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(1),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                          backgroundColor: MaterialStateProperty.all(Colors.red.shade600),
                          //shadowColor: MaterialStateProperty.all(Theme.of(context).colorScheme.onSurface)
                        ),
                        onPressed: (){
                          _newsController.addNews(titleController.text.trim(),descController.text.trim());
                          titleController.clear();
                          descController.clear();
                        },
                        child: Text('Add News')),
                  ],
                ),
              )
            ],
          ),
        ),
      ) ,
    );

  }

}