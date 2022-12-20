import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import '../../prefs/shared_prefs.dart';

class AddImage extends StatefulWidget {
  const AddImage({Key? key}) : super(key: key);

  @override
  _AddImageState createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  CollectionReference _reference = FirebaseFirestore.instance
      .collection('user')
      .doc(SharedPrefController().getId)
      .collection('gallery');

  GlobalKey<FormState> Key = GlobalKey();

  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('اضافة صورة للمعرض'),
        centerTitle: true,
        backgroundColor: Color(0xFF042C4C),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () async {
                ImagePicker imagePicker = ImagePicker();
                XFile? file =
                    await imagePicker.pickImage(source: ImageSource.gallery);
                print('${file?.path}');

                if (file == null) return;
                String uniquFileName =
                    DateTime.now().microsecondsSinceEpoch.toString();

                Reference referenceRoot = FirebaseStorage.instance.ref();
                Reference referenceDirImages =
                    referenceRoot.child(('imageGallery'));

                Reference referenceImageUp =
                    referenceDirImages.child(uniquFileName);

                try {
                  await referenceImageUp.putFile(File(file!.path));

                  imageUrl = await referenceImageUp.getDownloadURL();
                } catch (error) {}
              },
              icon: Icon(Icons.image,size: 50,),
            ),
            SizedBox(
              height: 40.h,
            ),
            ElevatedButton(
              onPressed: () async {
                // Map<String,String> dataToSend = {
                //   'image' : imageUrl,
                // };
                setState(() {
                  _reference.add({'image': imageUrl});
                });

                // Navigator.pushNamed(context, '/profile_screen');
              },
              child: const Text(
                'اضافة الصورة',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Color(0xFF042C4C),
                  minimumSize: const Size(150, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
