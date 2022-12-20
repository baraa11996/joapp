import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../controller/fb_auth_controller.dart';
import '../../controller/fb_image.dart';
import '../../prefs/shared_prefs.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  CollectionReference userref = FirebaseFirestore.instance.collection("user");
  double heightcontainer = 280;
  double profileheight = 144;
  double rating = 0;

  late File file;

  var imagepicker = ImagePicker();

  var url;

  final Stream<QuerySnapshot> gallery =
  FirebaseFirestore.instance.collection("user").snapshots();

  CollectionReference _reference = FirebaseFirestore.instance
      .collection('user').doc(SharedPrefController().getId).collection('gallery');


  Future<void> uploadFile(
      {required String filePath, required String name}) async {
    File file = File(filePath);
    try {
      await firebase_storage.FirebaseStorage.instance.ref(name).putFile(file);
    } on firebase_core.FirebaseException catch (e) {}
  }



  @override
  Widget build(BuildContext context) {
    final top = heightcontainer - profileheight / 2;

    return Scaffold(
      body: FutureBuilder(
          future: userref.doc(SharedPrefController().getId).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasData && !snapshot.data!.exists) {
              return Text("Document does not exist");
            }
            if (snapshot.hasError) {
              return Text('Eroor');
            }
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              return ListView(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: heightcontainer.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(data['image'] == ''
                                    ? 'https://img.freepik.com/free-photo/little-child-sitting-floor-pretty-smiling-surprised-boy-playing-with-wooden-cubes-home-conceptual-image-with-copy-negative-space_155003-38485.jpg'
                                    : "${data['image']}"))),
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20.r),
                                bottomRight: Radius.circular(20.r)),
                            gradient: LinearGradient(
                                begin: Alignment.bottomRight,
                                colors: [
                                  Colors.black.withOpacity(.7),
                                  Colors.black.withOpacity(.3),
                                ]),
                          ),
                        ),
                      ),
                      Positioned(
                        top: top,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: profileheight / 2 + 3,
                          child: CircleAvatar(
                            radius: profileheight / 2,
                            backgroundImage: NetworkImage(data['image'] == ''
                                ? 'https://img.freepik.com/free-photo/little-child-sitting-floor-pretty-smiling-surprised-boy-playing-with-wooden-cubes-home-conceptual-image-with-copy-negative-space_155003-38485.jpg'
                                : "${data['image']}"),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 5,
                        bottom: 0,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/select_image');
                          },
                          icon: Icon(
                            Icons.camera_alt,
                            color: Colors.grey,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: profileheight / 2 + 10.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'مرحبا بك ..',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            // Container(
                            //   width: double.infinity,
                            //   height: 80.h,
                            //   decoration: BoxDecoration(
                            //     color: Colors.grey.shade300,
                            //     borderRadius: BorderRadius.circular(25.r),
                            //   ),
                            //   child: Padding(
                            //     padding: const EdgeInsets.only(
                            //       left: 15,
                            //       top: 10,
                            //       right: 15,
                            //     ),
                            //     child: Column(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         Text('البريد الالكتروني'),
                            //         SizedBox(
                            //           height: 5.h,
                            //         ),
                            //         Divider(
                            //           height: 2.h,
                            //         ),
                            //         SizedBox(
                            //           height: 5.h,
                            //         ),
                            //         Text(
                            //           data['email'],
                            //           style: TextStyle(color: Colors.grey.shade600),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Container(
                              width: double.infinity,
                              height: 80.h,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(25.r),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 15,
                                  top: 10,
                                  right: 15,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text('المدينة'),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Divider(
                                          height: 2.h,
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          data['city'],
                                          style: TextStyle(color: Colors.grey.shade600),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text('الوظيفة'),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Divider(
                                          height: 2.h,
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          data['account type'],
                                          style: TextStyle(color: Colors.grey.shade600),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text('الاسم'),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Divider(
                                          height: 2.h,
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          data['username'],
                                          style: TextStyle(color: Colors.grey.shade600),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            // Container(
                            //   width: double.infinity,
                            //   height: 80.h,
                            //   decoration: BoxDecoration(
                            //     color: Colors.grey.shade300,
                            //     borderRadius: BorderRadius.circular(25.r),
                            //   ),
                            //   child: Padding(
                            //     padding: const EdgeInsets.only(
                            //       left: 15,
                            //       top: 10,
                            //       right: 15,
                            //     ),
                            //     child: Column(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         Text('الوظيفة'),
                            //         SizedBox(
                            //           height: 5.h,
                            //         ),
                            //         Divider(
                            //           height: 2.h,
                            //         ),
                            //         SizedBox(
                            //           height: 5.h,
                            //         ),
                            //         Text(
                            //           data['account type'],
                            //           style: TextStyle(color: Colors.grey.shade600),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text("التقييم : $rating"),
                            SizedBox(
                              height: 20.h,
                            ),
                            RatingBar.builder(
                              maxRating: 1,
                              itemBuilder: (context,_) => Icon(Icons.star,color: Colors.amber,),
                              updateOnDrag: true,
                              onRatingUpdate: (rating) => setState((){
                                this.rating = rating ;
                              }),
                            ),
                            SizedBox(height: 15.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/add_image');
                                  },
                                  // style: ElevatedButton.styleFrom(
                                  //     primary: Color(0xFF042C4C),
                                  //     shape: RoundedRectangleBorder(
                                  //       borderRadius: BorderRadius.circular(30),
                                  //     )),
                                  child: const Text('اضافة صورة',style: TextStyle(fontSize: 15),),
                                ),
                                Text(
                                  'معرض الأعمال',
                                  style: TextStyle(fontSize: 15.sp),
                                ),
                              ],
                            ),
                            SizedBox(height: 15.h,),
                            SizedBox(
                              height: 250.h,
                              width: double.infinity,
                              child: StreamBuilder(
                                stream: _reference.snapshots(),
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
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 50.h,
                                          width: 100.w,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20.r),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage('${data.docs[index]['image']}',)
                                              )
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              )
                            ),
                            SizedBox(height: 15.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 27,
                                  backgroundColor: Colors.grey,
                                  child: InkWell(
                                    onTap: (){},
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Colors.white,
                                      backgroundImage: AssetImage('images/facebook.png'),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 7),
                                CircleAvatar(
                                  radius: 27,
                                  backgroundColor: Colors.grey,
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 23,
                                      backgroundColor: Colors.white,
                                      backgroundImage: AssetImage('images/instegram.png'),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 7),
                                InkWell(
                                  onTap: _launchEmail,
                                  child: CircleAvatar(
                                    radius: 27,
                                    backgroundColor: Colors.grey,
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Colors.white,
                                      backgroundImage: AssetImage('images/gmail.png'),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 7),
                                CircleAvatar(
                                  radius: 27,
                                  backgroundColor: Colors.grey,
                                  child: InkWell(
                                    onTap: calling,
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Colors.white,
                                      backgroundImage: AssetImage(
                                        'images/whatsapp.png',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15.h,),
                            ElevatedButton(
                              onPressed: () async {
                                await FbAuthController().signOut();
                                Navigator.pushReplacementNamed(
                                    context, '/sginin_screen');
                              },
                              child: const Text(
                                'Log out',
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF042C4C),
                                  minimumSize: const Size(300, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  )),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),


                ],
              );
            }
            return SizedBox();
          }),
    );
  }
  _launchEmail() async {
    String email="baraa.2034@gmail.com";
    if (await canLaunch("mailto:$email")) {
      await launch("mailto:$email");
    } else {
      throw 'Could not launch';
    }
  }

  calling()async{
    const url = 'tel:+972592280534';
    if( await canLaunch(url)){
      await launch(url);
    }else{
      throw 'Could not launch $url';
    }
  }
  whatsapp()async{
    const url = "whatsapp://send?phone=+972592280534";
    if( await canLaunch(url)){
      await launch(url);
    }else{
      throw 'Could not launch $url';
    }
  }
  facebook()async{
    const url = "https://www.facebook.com/profile.php?id=100016234727888";
    if( await canLaunch(url)){
      await launch(url);
    }else{
      throw 'Could not launch $url';
    }
  }
  instegram()async{
    const url = "https://www.instagram.com/baraa.m.barhoom2?utm_medium=copy_link";
    if( await canLaunch(url)){
      await launch(url);
    }else{
      throw 'Could not launch $url';
    }
  }
}
