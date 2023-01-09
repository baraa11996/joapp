import 'package:cloud_firestore/cloud_firestore.dart';

class SubmitModel {
  late String? postId;
  late String? body;
  late String? userUId;
  late Timestamp? timeStamp;

  SubmitModel();

  SubmitModel.fromMap(Map<String, dynamic> map) {
    postId = map['postId'];
    body = map['body'];
    userUId = map['userUId'];
    timeStamp = map['timeStamp'];
  }

  Map<String, dynamic> get toMap {
    Map<String, dynamic> map = {};
    map['postId'] = postId;
    map['body'] = body;
    map['userUId'] = userUId;
    map['timeStamp'] = timeStamp;
    return map;
  }
}
