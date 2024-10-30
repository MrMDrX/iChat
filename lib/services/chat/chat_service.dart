import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final _db = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _db
        .collection('users')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}
