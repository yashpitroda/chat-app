import 'package:chatapp/widgets/chat/messages_widgets.dart';
import 'package:chatapp/widgets/chat/new_massages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//calection has 0 to n document -- so c is list of document
//each document contain a map and this map hold uid,text,title,datetime

//list of document are store in array or list
//and in document all feild are store in map
//every document
class ChatScreen extends StatelessWidget {
  // final collectionPath = 'chats/KitmGKnOiepZHhf2CsMW/messages';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // elevation: 10,
          title: Text('FlutterChat'),
          actions: [
            DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).backgroundColor,
              ),
              items: [
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.black,
                        ),
                        SizedBox(width: 8),
                        Text('Logout'),
                      ],
                    ),
                  ),
                  value: 'logout',
                ),
              ],
              onChanged: (itemIdentifier) {
                if (itemIdentifier == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              },
            ),
          ],
        ),
        body:
            // StreamBuilder(
            //   stream: FirebaseFirestore.instance
            //       .collection(collectionPath)
            //       .snapshots(), //when ever this database changes at that time it weill automatic call and fatch the data
            //   //whenever stream givs new value at that time bulder re executed

            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     }
            //     final document = snapshot.data?.docs;
            //     return ListView.builder(
            //       // itemCount: snapshot.data?.docs.length,
            //       itemCount: document!.length,
            //       itemBuilder: (ctx, index) => Container(
            //         padding: EdgeInsets.all(8),
            //         // child: Text(snapshot.data?.docs[index]['text']),
            //         child: Text(document[index]['text']),
            //       ),
            //     );
            //   },
            // ),
            Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child:
                    MassagesWidget(), //MassagesWidget contains listview so //we MassagesWidget is not inislise in expanded
              ),
              NewMessage()
            ],
          ),
        )
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.add),
        //   onPressed: () {
        //     //     .listen((event) {
        //     //   // print(event.docs[0]['text']); //only one
        //     //   event.docs.forEach((element) {
        //     //     //it pint all massages element
        //     //     print(element['text']);
        //     //   });
        //     // }); //now we acessing massages collection
        //     //sanpshots is a strime //any changes occur in this lisnten will call automaticaly

        //     FirebaseFirestore.instance
        //         .collection(collectionPath)
        //         .add({'text': 'hello mera name hai doremon'});
        //   },
        // ),
        );
  }
}
