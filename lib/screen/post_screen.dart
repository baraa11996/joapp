import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../models/category.dart';
import '../models/post.dart';
import '../prefs/shared_prefs.dart';


class PostScreen extends StatefulWidget {
  final Category category;

  PostScreen({
    required this.category,
  });

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  final postRef = FirebaseFirestore.instance.collection("posts");

  final now = DateTime.now();
  final formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  final Stream<QuerySnapshot> postsRef =
  FirebaseFirestore.instance.collection("posts").snapshots();

  CollectionReference _reference = FirebaseFirestore.instance
      .collection('user');

  late TextEditingController _titleEditingController;
  late TextEditingController _contentEditingController;
  late TextEditingController _priceEditingController;

  @override
  void initState() {
    super.initState();
    _titleEditingController = TextEditingController();
    _contentEditingController = TextEditingController();
    _priceEditingController = TextEditingController();

  }

  @override
  void dispose() {
    _titleEditingController.dispose();
    _contentEditingController.dispose();
    _priceEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('صفحة ال'+widget.category.name,style: TextStyle(fontSize: 22.sp),),
        centerTitle: true,
        backgroundColor: Color(0xFF042C4C),
        toolbarHeight: 70,
      ),
      body: StreamBuilder(
        stream: postsRef,
        builder: (
            BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot,
            ) {
          if (snapshot.hasError) {
            return Text('Eroor');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final data = snapshot.requireData;
          return Padding(
            padding: const EdgeInsets.only(
              top: 17,
              left: 5,
              right: 5,
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: 15,
                    right: 7,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'بحث عن المستخدمين',
                      suffixIcon: Icon(
                        Icons.search,
                        color: Color(0xFF042C4C),
                      ),
                      hintStyle: TextStyle(
                        color: Color(0xFF042C4C),
                      ),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: data.size,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          left: 5,
                          right: 5,
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 15.h,),
                            Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: const[
                                          CircleAvatar(
                                            child: Icon(Icons.person),
                                            radius: 15,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(''),
                                        ],
                                      ),
                                      Text('${data.docs[index]['date']}',style: TextStyle(color: Colors.grey),),
                                    ],
                                  ),
                                  Text('${data.docs[index]['title']}',style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold),),
                                  SizedBox(height: 5.h,),
                                  Divider(
                                    color: Colors.grey,
                                    height: 1,
                                  ),
                                  SizedBox(height: 10.h,),
                                  Text('${data.docs[index]['content']}',style: TextStyle(),),
                                  SizedBox(height: 10.h,),
                                  Text('${data.docs[index]['price']}',style: TextStyle(),),
                                  SizedBox(height: 20.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.favorite_border,color: Colors.grey,),
                                          SizedBox(width: 4,),
                                          Text('اضافة للمفضلة'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.add_box,color: Colors.grey,),
                                          SizedBox(width: 4,),
                                          Text('تقديم للوظيفة'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),

      floatingActionButton: SharedPrefController().userType == '1' ? FloatingActionButton(
        onPressed: () {

          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("نشر الوظيفة",textAlign: TextAlign.center),
                content: Container(
                  height: 350.h,
                  child: Column(
                    children: [
                      TextField(
                        controller: _titleEditingController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "اسم الوظيفة",
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      TextField(
                        controller: _contentEditingController,
                        textInputAction: TextInputAction.newline,
                        maxLines: 5,
                        minLines: 4,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "محتوى الوظيفة",
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: _priceEditingController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "السعر بالشيكل",
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        child: Text("الغاء"),
                        onPressed: () {
                          // Handle cancel action
                        },
                      ),
                      TextButton(
                        child: Text("نشر"),
                        onPressed: () {
                          performPost();
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ) : null,
    );
  }

  void performPost()  {
    if (checkData()) {

      postes();
    }
  }

  bool checkData() {
    if (_titleEditingController.text.isNotEmpty &&
        _contentEditingController.text.isNotEmpty &&
        _priceEditingController.text.isNotEmpty ) {
      return true;
    }

    return false;
  }

  void postes()  {

    final post = Post(_titleEditingController.text, _contentEditingController.text,int.parse(_priceEditingController.text), widget.category.name);
    postRef.add({
      'title' : post.title,
      'content' : post.content,
      'price' : post.price,
      'nameGategory' : post.nameCategory,
      'idUser': SharedPrefController().getId,
      'date':formattedDate,
    });
    Navigator.pop(context);
  }
}
