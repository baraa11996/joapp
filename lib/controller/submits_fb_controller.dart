import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:joapp/models/submit_model.dart';

class FbSubmitsController {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;

  Future<void> addSubmit(SubmitModel submitModel) async {
    await _firebase.collection('submits').add(submitModel.toMap);
  }

  Stream<QuerySnapshot<SubmitModel>> getSubmits(String postId) async* {
    yield* _firebase
        .collection('submits')
        .where('postId', isEqualTo: postId)
        .orderBy('timeStamp', descending: true)
        .withConverter<SubmitModel>(
          fromFirestore: (snapshot, options) =>
              SubmitModel.fromMap(snapshot.data()!),
          toFirestore: (value, options) => value.toMap,
        )
        .snapshots();
  }
}
