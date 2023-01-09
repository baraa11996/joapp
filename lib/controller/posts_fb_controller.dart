import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:joapp/models/post.dart';

class FbPostsController {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;

  Future<void> addPost(PostModel postModel) async {
    await _firebase.collection('posts').add(postModel.toMap);
  }

  Stream<QuerySnapshot<PostModel>> getPosts(String categoryId) async* {
    yield* _firebase
        .collection('posts')
        .where('categoryId', isEqualTo: categoryId)
        .withConverter<PostModel>(
          fromFirestore: (snapshot, options) =>
              PostModel.fromMap(snapshot.data()!),
          toFirestore: (value, options) => value.toMap,
        )
        .snapshots();
  }
}
