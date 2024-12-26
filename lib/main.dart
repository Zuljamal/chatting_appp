import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:chatting_app/screens/welcome_screen.dart';
import 'package:chatting_app/screens/login_screen.dart';
import 'package:chatting_app/screens/registration_screen.dart';
import 'package:chatting_app/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb){ await Firebase.initializeApp(
  options: FirebaseOptions(
  apiKey: "AIzaSyD1z32VTWLJ-VV-CY1qlv82IMa8FqbIg1U",
  authDomain: "chatting-app-f444c.firebaseapp.com",
  projectId: "chatting-app-f444c",
  storageBucket: "chatting-app-f444c.firebasestorage.app",
  messagingSenderId: "946587761077",
  appId: "1:946587761077:web:64acb76cf4e76ee650c1fc",
  ),
  );}
  else {
    Firebase.initializeApp();
  }

  runApp(FlashChat());
}



class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}
