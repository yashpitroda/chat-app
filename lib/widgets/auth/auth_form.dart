import 'package:flutter/material.dart';

enum AuthMode { Signup, Signin }

class AuthForm extends StatefulWidget {
  final Function submitdata;
  final isloading;
  const AuthForm({super.key, required this.submitdata,required this.isloading});
  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();
  AuthMode _authMode = AuthMode.Signin;

  String _userEmail = '';
  String _userpassword = '';
  String _username = '';

  bool _isSignIn = false;
  void _switchAuthMode() {
    if (_authMode == AuthMode.Signin) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      //we move to login page to signup page
      // _animationController!.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Signin;
      });
      // _animationController!.reverse();
    }
  }

  void _showErrorDialog(String masage) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("an error occur"),
              content: Text(masage),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("okey"))
              ],
            ));
  }

  void _trySave() {
    _isSignIn = (_authMode == AuthMode.Signin);
    final isvalid = _formkey.currentState!.validate();
    FocusScope.of(context)
        .unfocus(); //after tap in to signin botten keybord will close //itt is close the focus form input

    if (isvalid) {
      _formkey.currentState!.save();
      // print(_userEmail);
      // print(_username);
      // print(_userpassword);

      widget.submitdata(
        _userEmail.trim(),
        _username.trim(),
        _userpassword.trim(),
        _isSignIn,
      );
      //do not need to do this
      // try {
      //   widget.submitdata(_userEmail, _username, _userpassword, _isSignIn);
      // } catch (e) {
      //   var masage = "Authentication failed... " + e.toString();
      //   _showErrorDialog(masage);
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryhelp = MediaQuery.of(context).size;
    return Center(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        height: _authMode == AuthMode.Signup
            ? MediaQueryhelp.height * 0.36
            : MediaQueryhelp.height * 0.29,
        child: Card(
            child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    key: ValueKey('emailKey'),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'enter a valid email address';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email Adress'),
                    onSaved: (newValue) {
                      _userEmail = newValue!;
                    },
                  ),
                  if (_authMode == AuthMode.Signup)
                    TextFormField(
                      key: ValueKey('nameKey'),
                      onSaved: (newValue) {
                        _username = newValue!;
                      },
                      validator: (value) {
                        if (value!.isEmpty || value.length < 4) {
                          return 'username is too short';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(labelText: 'Username'),
                    ),
                  TextFormField(
                    key: ValueKey('passwdkey'),
                    onSaved: (newValue) {
                      _userpassword = newValue!;
                    },
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'password must be atlist 7 character more!';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true, //hide pass
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  if (widget.isloading) CircularProgressIndicator(),
                  if (!widget.isloading)
                    ElevatedButton(
                      onPressed: _trySave,
                      child: Text(
                          (_authMode == AuthMode.Signin ? 'Signin' : "Signup")),
                    ),
                  if (!widget.isloading)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_authMode == AuthMode.Signin
                            ? 'Create an account! '
                            : "Already have an account! "),
                        TextButton(
                          onPressed: _switchAuthMode,
                          child: Text(_authMode == AuthMode.Signin
                              ? 'Signup'
                              : "Signin"),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
