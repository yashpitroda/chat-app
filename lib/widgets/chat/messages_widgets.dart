import 'package:chatapp/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MassagesWidget extends StatelessWidget {
  MassagesWidget({super.key});
  User? currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chats')
          .orderBy('createdAt', descending: true)
          .snapshots(),

      //when ever this database changes at that time it weill automatic call and fatch the data
      //whenever stream givs new value at that time bulder re executed

      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        //else
        final chatdocument = snapshot.data?.docs;
        return ListView.builder(
          reverse: true, //botton to top
          itemCount: chatdocument!.length,
          itemBuilder: (ctx, index) => MessageBubble(
            chatdocument[index]['text'],
            chatdocument[index]['userName'],
            chatdocument[index]['userImageUrl'],
            (chatdocument[index]['userId'] == currentUser!.uid),
            key: ValueKey(chatdocument[index].id),
          ),
        );
      },
    );
  }
}
