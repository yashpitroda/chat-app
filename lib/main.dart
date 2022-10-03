import 'package:chatapp/screens/auth_screen.dart';
import 'package:chatapp/screens/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'flutter chat',
      theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.green,
          buttonTheme: ButtonTheme.of(context).copyWith(
            // buttonColor: Colors.blue,
            // textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          )),
      home: StreamBuilder(
        stream: FirebaseAuth.instance
            .authStateChanges(), //it give a token whter it is authenticed or not
        builder: (context, userSnapshot) {
          if (userSnapshot.hasData) {
            //if data is found mean userr authanticated so we go to chatscreem
            return ChatScreen();
          } else {
            //and no data so not auth.. so retry
            return AuthScreen();
          }
        },
      ),
    );
  }
}
