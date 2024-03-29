import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _textcontroller = new TextEditingController();
  var _enteredMessage = '';
  final collectionPath = 'chats';
  void _sendMessage() async {
    FocusScope.of(context).unfocus(); //exit to keybord
    final currentUser = await FirebaseAuth.instance.currentUser;
    final userdocData= await FirebaseFirestore.instance.collection('users').doc(currentUser!.uid).get();
    FirebaseFirestore.instance.collection(collectionPath).add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': currentUser.uid,
      'userName':userdocData['userName'],
      'userImageUrl':userdocData['userImageUrl']
    }); 
    _textcontroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textcontroller,
              decoration: InputDecoration(labelText: 'Send a message...'),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(
              Icons.send,
            ),
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          )
        ],
      ),
    );
  }
}
