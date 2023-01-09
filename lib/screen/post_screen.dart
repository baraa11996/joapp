import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:joapp/controller/posts_fb_controller.dart';
import 'package:joapp/widgets/post_item.dart';

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

  CollectionReference _reference =
      FirebaseFirestore.instance.collection('user');

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
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'صفحة ال' + widget.category.name,
          style: TextStyle(fontSize: 22.sp),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF042C4C),
        toolbarHeight: 70,
      ),
      body: StreamBuilder<QuerySnapshot<PostModel>>(
        stream: FbPostsController().getPosts(widget.category.id),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final posts = snapshot.data?.docs ?? [];
          return Padding(
            padding: const EdgeInsets.only(
              top: 17,
              left: 5,
              right: 5,
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 7,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const TextField(
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
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return PostItem(post: posts[index].data());
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: SharedPrefController().userType == 1
          ? FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      scrollable: true,
                      title: const Text("نشر الوظيفة",
                          textAlign: TextAlign.center),
                      content: SizedBox(
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
                            SizedBox(
                              height: 20.h,
                            ),
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
                            SizedBox(
                              height: 20.h,
                            ),
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
                                Navigator.pop(context);
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
            )
          : null,
    );
  }



  void performPost() {
    if (checkData()) {
      addPost;
    }
  }

  bool checkData() {
    if (_titleEditingController.text.isNotEmpty &&
        _contentEditingController.text.isNotEmpty &&
        _priceEditingController.text.isNotEmpty) {
      return true;
    }

    return false;
  }

  Future<void> get addPost async {
    await FbPostsController().addPost(post);

    Navigator.pop(context);
  }

  PostModel get post {
    PostModel postModel = PostModel();
    postModel.title = _titleEditingController.text;
    postModel.content = _contentEditingController.text;
    postModel.price = int.parse(_priceEditingController.text);
    postModel.nameCategory = widget.category.name;
    postModel.categoryId = widget.category.id;
    postModel.userId = SharedPrefController().getId;
    postModel.timeStamp = Timestamp.now();
    return postModel;
  }
}
