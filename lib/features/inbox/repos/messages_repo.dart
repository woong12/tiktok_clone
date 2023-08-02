import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/message_model.dart';

class MessagesRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> sendMessage(MessageModel message) async {
    _db
        .collection("chat_rooms")
        .doc("kyyqmkxQC1iqlgxLZPGz")
        .collection("texts")
        .add(
          message.toJson(),
        );
  }
}

final messagesRepo = Provider((ref) => MessagesRepo());
