import 'package:chatting_app/constants.dart';
import 'package:chatting_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:chatting_app/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'Login_Screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
   late String email ;
   late String password;
   bool ShowSpinner= false;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: ShowSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                onChanged: (value) {
                  email = value;
                },

                  textAlign: TextAlign.center,
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your Email')
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                onChanged: (value) {
                  password = value;
                },
                  obscureText: true,
                  textAlign: TextAlign.center,
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your Password', )
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Login',
                color: Colors.lightBlueAccent,
                onPressed: () async {
                  setState(() {
                    ShowSpinner = true;
                  });
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                  }
                  catch(e)
                  {print (e);}
                  setState(() {
                    ShowSpinner = false;
                  });
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
