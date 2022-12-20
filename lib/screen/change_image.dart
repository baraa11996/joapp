import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;

import '../controller/fb_storage.dart';
import '../prefs/shared_prefs.dart';


class ChangeImage extends StatefulWidget {
  const ChangeImage({Key? key}) : super(key: key);

  @override
  _ChangeImageState createState() => _ChangeImageState();
}

class _ChangeImageState extends State<ChangeImage> {
  CollectionReference userref = FirebaseFirestore.instance.collection("user");
  late File file;

  var imagepicker = ImagePicker();

  var url;

  Future<void> uploadFile(
      {required String filePath, required String name}) async {
    File file = File(filePath);
    try {
      await firebase_storage.FirebaseStorage.instance.ref(name).putFile(file);
    } on firebase_core.FirebaseException catch (e) {}
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Image',style: TextStyle(fontSize: 26.sp),),
        centerTitle: true,
        toolbarHeight: 80.h,
        backgroundColor: Color(0xFF042C4C),
      ),
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
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 72,
                      child: CircleAvatar(
                        radius: 70,
                        backgroundImage:  NetworkImage(
                      data['image'] == '' ? 'https://img.freepik.com/free-photo/little-child-sitting-floor-pretty-smiling-surprised-boy-playing-with-wooden-cubes-home-conceptual-image-with-copy-negative-space_155003-38485.jpg' : "${data['image']}"),
                      ),
                    ),
                    SizedBox(height: 30.h,),
                    TextButton(onPressed: ()async {
                      print('*****************************');
                      print(SharedPrefController().getId);
                      print('*****************************');
                      var imagepicked = await imagepicker.pickImage(
                          source: ImageSource.gallery);

                      File file = File(imagepicked!.path);
                      await FbStorageUsersController().uploadImage(
                        file: file,
                        context: context,
                        callBackUrl: ({
                          required String url,
                          required bool status,
                        }) {

                          print('URL => $url');
                          print('status => $status');
                          userref.doc(SharedPrefController().getId).update(
                            {
                              'image':url,
                            },
                          );
                          setState(() {

                          });
                        },
                      );
                    }, child: Text('Select Image'))
                  ],
                ),
              );
            }
            return SizedBox();
          }),
    );
  }
}
