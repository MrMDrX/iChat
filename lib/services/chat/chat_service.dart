import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ichat/models/message.dart';

class ChatService {
  final _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _db
        .collection('users')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Future<void> sendMessage(String receiverId, String message) async {
    final String senderId = _auth.currentUser!.uid;
    final String senderEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
      senderId: senderId,
      senderEmail: senderEmail,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
    );

    List<String> userIds = [senderId, receiverId];
    userIds.sort();
    String chatId = userIds.join('_');
    await _db
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessagesStream(String userId, String otherUserId) {
    List<String> userIds = [userId, otherUserId];
    userIds.sort();
    String chatId = userIds.join('_');
    return _db
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
