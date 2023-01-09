import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joapp/controller/users_fb_controller.dart';
import 'package:joapp/models/post.dart';
import 'package:joapp/prefs/shared_prefs.dart';
import 'package:joapp/screen/submits_screen.dart';

class PostItem extends StatefulWidget {
  final PostModel post;

  const PostItem({
    required this.post,
    Key? key,
  }) : super(key: key);

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  @override
  void initState() {
    super.initState();
    getUserData;
  }

  Map<String, dynamic>? userData;

  Future<void> get getUserData async {
    var user = await FbUsersController().getUser(widget.post.userId!);
    setState(() {
      userData = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        left: 5,
        right: 5,
      ),
      child: Column(
        children: [
          SizedBox(height: 15.h),
          Container(
            padding: const EdgeInsets.all(15),
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
                      children: [
                        Container(
                          width: 30.w,
                          height: 30.h,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            userData?['image'] ?? '',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.person);
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(userData?['username']
                                .toString()
                                .substring(0, 2)
                                .split('')
                                .join('.') ??
                            ''),
                      ],
                    ),
                    Text(
                      time(widget.post.timeStamp!),
                      style: TextStyle(color: Colors.grey, fontSize: 10.sp),
                    ),
                  ],
                ),
                Text(
                  widget.post.title ?? '',
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5.h),
                const Divider(
                  color: Colors.grey,
                  height: 1,
                ),
                SizedBox(height: 10.h),
                Text(widget.post.content ?? ''),
                SizedBox(height: 10.h),
                Text(widget.post.price?.toString() ?? ''),
                SharedPrefController().userType == 2
                    ? Column(
                        children: [
                          SizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  /// TODO: Add Favorite
                                },
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.favorite_border,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(width: 4),
                                    Text('اضافة للمفضلة'),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SubmitsScreen(
                                              post: widget.post)));
                                },
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.add_box,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(width: 4),
                                    Text('تقديم للوظيفة'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String time(Timestamp timestamp) {
    var date = timestamp.toDate();
    return '${date.year}/${date.month}/${date.day} ${date.hour}:${date.minute}';
  }
}
