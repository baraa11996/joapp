import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joapp/models/submit_model.dart';

import '../controller/submits_fb_controller.dart';
import '../models/post.dart';
import '../prefs/shared_prefs.dart';

class SubmitsScreen extends StatefulWidget {
  final PostModel post;

  SubmitsScreen({
    required this.post,
  });

  @override
  State<SubmitsScreen> createState() => _SubmitsScreenState();
}

class _SubmitsScreenState extends State<SubmitsScreen> {
  final postRef = FirebaseFirestore.instance.collection("submits");

  late TextEditingController _titleEditingController;

  @override
  void initState() {
    super.initState();
    _titleEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _titleEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'تقديم عرض',
          style: TextStyle(fontSize: 22.sp),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF042C4C),
        toolbarHeight: 70,
      ),
      body: StreamBuilder<QuerySnapshot<SubmitModel>>(
        stream: FbSubmitsController().getSubmits(widget.post.id!),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final submits = snapshot.data?.docs ?? [];
          return Padding(
            padding: const EdgeInsets.only(
              top: 17,
              left: 5,
              right: 5,
              bottom: 10,
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: submits.length,
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 5.h),
                        margin: EdgeInsets.only(bottom: 10.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(),
                        ),
                        child: Text(submits[index].data().body ?? ''),
                      );
                    },
                  ),
                ),
                TextField(
                  controller: _titleEditingController,
                  decoration: InputDecoration(
                    hintText: 'أدخل العرض الخاص بك',
                    focusedBorder: buildOutlineInputBorder(),
                    enabledBorder: buildOutlineInputBorder(),
                    suffixIcon: InkWell(
                      onTap: () async {
                        await performPost;
                      },
                      child: const Icon(Icons.send),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.r),
    );
  }

  Future<void> get performPost async {
    if (checkData()) {
      addPost;
    }
  }

  bool checkData() {
    if (_titleEditingController.text.isNotEmpty) {
      return true;
    }

    return false;
  }

  Future<void> get addPost async {
    await FbSubmitsController().addSubmit(submit);
    setState(() {
      _titleEditingController.clear();
    });
  }

  SubmitModel get submit {
    SubmitModel submitModel = SubmitModel();
    submitModel.postId = widget.post.id;
    submitModel.body = _titleEditingController.text;
    submitModel.userUId = SharedPrefController().getId;
    submitModel.timeStamp = Timestamp.now();
    return submitModel;
  }
}
