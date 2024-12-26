import 'package:flutter/material.dart';
import 'package:chatting_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
User? loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'Chat_Screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  late String messageText;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    final user = FirebaseAuth.instance.currentUser;
    try {
      if (user != null) {
        loggedInUser = user;
        print('Logged in as: ${user.email}');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min, // Keeps the Row size minimal
            children: [
              Icon(
                Icons.flash_on, // Thunder icon
                color: Colors.yellowAccent, // Icon color
              ),
              SizedBox(width: 8), // Space between icon and text
              Text(
                'Chat',
                style: TextStyle(
                  color: Colors.white, // Text color
                  fontSize: 20, // Adjust font size as needed
                  fontWeight: FontWeight.bold, // Optional: Make it bold
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.lightBlueAccent,


      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextController.clear();
                      _firestore.collection('messages').add({
                        'text': messageText,
                        'sender': loggedInUser!.email,
                        'timestamp': FieldValue.serverTimestamp(),
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class MessageStream extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').orderBy('timestamp').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final messages =
              snapshot.data!.docs; // Access documents safely with `!`
          List<MessageBubble> messageBubbles = [];

          for (var message in messages) {
            final messageText = message['text']; // Get the 'text' field
            final messageSender = message['sender']; // Get the 'sender' field
            final currentUser = loggedInUser?.email;

            if (currentUser == loggedInUser){

            }
            // Create a Text widget and add it to the list
            final messageBubble =
            MessageBubble(sender: messageSender, text: messageText, isMe: currentUser == messageSender,);
            messageBubbles.add(messageBubble);
          }

          return Expanded(
            child: ListView(
              padding:
              EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: messageBubbles,
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}




class MessageBubble extends StatelessWidget {
  MessageBubble({required this.sender, required this.text, required this.isMe});
  late final String sender;
  late final String text;
  bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10), // Outer padding
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Material(
            borderRadius: isMe ? BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30) )  : BorderRadius.only(topRight: Radius.circular(30), bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30) ),
            color: isMe ? Colors.lightBlueAccent : Colors.grey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 15.0,
              ), // Inner padding
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
