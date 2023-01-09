import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  late String? id;
  late String? title;
  late String? content;
  late int? price;
  late String? nameCategory;
  late String? categoryId;
  late String? userId;
  late Timestamp? timeStamp;

  PostModel();

  PostModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    content = map['content'];
    price = map['price'];
    nameCategory = map['nameCategory'];
    categoryId = map['categoryId'];
    userId = map['userId'];
    timeStamp = map['timeStamp'];
  }

  Map<String, dynamic> get toMap {
    Map<String, dynamic> map = {};

    map['id'] = id;
    map['title'] = title;
    map['content'] = content;
    map['price'] = price;
    map['nameCategory'] = nameCategory;
    map['categoryId'] = categoryId;
    map['userId'] = userId;
    map['timeStamp'] = timeStamp;
    return map;
  }
}
