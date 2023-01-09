import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joapp/screen/person_screen.dart';
import 'package:joapp/screen/post_screen.dart';

import '../models/category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> imgList = [
    'images/jobs1.jpg',
    'images/jobs1.jpg',
    'images/jobs1.jpg',
  ];
  late TextEditingController _searchController;

  final Stream<QuerySnapshot> storyref =
      FirebaseFirestore.instance.collection("user").snapshots();

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الصفحة الرئيسية'),
        centerTitle: true,
        backgroundColor: const Color(0xFF042C4C),
        leadingWidth: 0,
        leading: const SizedBox.shrink(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                      hintText: 'البحث',
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
                SizedBox(
                  height: 15.h,
                ),
                CarouselSlider(
                    items: imgList
                        .map(
                          (item) => Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Stack(
                                children: [
                                  Image.asset(
                                    item,
                                    fit: BoxFit.cover,
                                    width: 800.w,
                                    height: 200.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 2.7,
                      enlargeCenterPage: true,
                    )),
                SizedBox(
                  height: 25.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/category_screen');
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xFF042C4C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          )),
                      child: const Text('مشاهدة الكل'),
                    ),
                    Text(
                      'فئات التطبيق',
                      style: TextStyle(fontSize: 20.sp),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25.h,
                ),
                SizedBox(
                  height: 150.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PostScreen(category: category),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          clipBehavior: Clip.antiAlias,
                          width: 200.w,
                          height: 400.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  category.image,
                                ),
                              )),
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.bottomRight,
                                    colors: [
                                  Colors.black.withOpacity(.8),
                                  Colors.black.withOpacity(.2),
                                ])),
                            child: Center(
                              child: Text(
                                category.name,
                                style: TextStyle(
                                    fontSize: 30.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xFF042C4C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          )),
                      child: const Text('مشاهدة الكل'),
                    ),
                    Text(
                      'افضل المستخدمين',
                      style: TextStyle(fontSize: 20.sp),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                SizedBox(
                  height: 270.h,
                  width: double.infinity,
                  child: StreamBuilder(
                    stream: storyref,
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
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.size,
                        itemBuilder: (context, index) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) {
                                      return PersonScreen(
                                        docid: data.docs[index].id,
                                      );
                                    }),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 10),
                                  // clipBehavior: Clip.antiAlias,
                                  width: 220.w,
                                  height: 230.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.r),
                                    color: Colors.white70,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 150.h,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    '${data.docs[index]['image']}',
                                                  ))),
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '${data.docs[index]['account type']}',
                                                  style: TextStyle(
                                                      fontSize: 18.sp),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              '${data.docs[index]['username']}',
                                              style: TextStyle(
                                                  color: Color(0xFF042C4C),
                                                  fontSize: 12.sp),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
