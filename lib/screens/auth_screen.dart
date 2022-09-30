import 'package:chatapp/widgets/auth/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  void _submitAuthform(
      String email, String username, String password, bool isSignIn) async {
    print(email);
    print(username);
    print(password);
    print(isSignIn);

    try {
      setState(() {
        _isLoading = true;
      });
      if (isSignIn) {
        //do signin or login
        final authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 2),
          content: Text(
            'SignIn sucessfull.',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Theme.of(context).backgroundColor,
        ));
        print('signin completed');
        print(authResult);
        print(authResult.user);
        print(authResult.additionalUserInfo);
      } else {
        //do signup
        final authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        final userIdByFirebase = authResult.user!.uid;
        FirebaseFirestore.instance
            .collection('users')
            .doc(userIdByFirebase)
            .set({
          'userName': username,
          'userEmail': email,
        }
        );
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 2),
          content: Text(
            'SignUp completed || switch to signIn.',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Theme.of(context).backgroundColor,
        ));
      }
      setState(() {
        _isLoading = false;
      });
    } on PlatformException catch (e) {
      //method 1
      // throw e;

      //method 2
      var masage = "Authentication failed... \n" + e.message.toString();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(masage),
        backgroundColor: Theme.of(context).errorColor,
      ));
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      var masage = "Authentication failed... \n" + err.toString();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(masage),
        backgroundColor: Theme.of(context).errorColor,
      ));
      // throw err;
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: AuthForm(
          submitdata: _submitAuthform,
          isloading: _isLoading,
        ),
      ),
    );
  }
}
