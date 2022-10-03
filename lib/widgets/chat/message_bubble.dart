import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(this.message, this.username, this.isMe, {required this.key});
  final username;
  final Key key;
  final String message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          //mrgin
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          child: Container(
            decoration: BoxDecoration(
              color:
                  isMe ? Theme.of(context).primaryColorDark : Colors.grey[300],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
              ),
            ),
            width: 140,
            // padding: EdgeInsets.symmetric( //innner content(text) space
            //   vertical: 10,
            //   horizontal: 16,
            // ),
            // margin: EdgeInsets.symmetric( //space of out of container
            //   vertical: 4,
            //   horizontal: 8,
            // ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: isMe ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.black,
                    ),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
