import 'package:chatting_app/screens/login_screen.dart';
import 'package:chatting_app/screens/registration_screen.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatting_app/components/rounded_button.dart';


class WelcomeScreen extends StatefulWidget {
  static const String id = 'Welcome_Screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation SizeAnimation;
  late Animation ColorAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    SizeAnimation = Tween<double>(begin: 0, end: 70)
        .animate(CurvedAnimation(parent: controller, curve: Curves.decelerate));
    ColorAnimation =
        ColorTween(begin: Colors.blue, end: Colors.white).animate(controller);

    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorAnimation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('images/logo.png'),
                      height: SizeAnimation.value,
                    ),
                  ),
                ),
                TypewriterAnimatedTextKit(
                  speed: Duration(milliseconds: 150),

                  text: ['Flash Chat'],
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 45,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Register',
              color: Colors.blueAccent,
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Log In',
              color: Colors.blueAccent,
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}


