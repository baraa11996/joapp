import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:joapp/models/post.dart';

class FbUsersController {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getUser(String uId) async {
    var user = await _firebase.collection('user').doc(uId).get();
    return user.data() ?? {};
  }
}
