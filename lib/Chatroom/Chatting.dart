import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:tt/Constants/FirebaseConstants.dart';

class Chatting extends StatefulWidget {
  @override
  _ChattingState createState() => _ChattingState();
}

class _ChattingState extends State<Chatting> {
  DatabaseReference _firebaseMsgDbRef;

  FirebaseUser _user;
  final TextEditingController _textController = TextEditingController();
  bool _isComposing = false;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now().toUtc();
    this._firebaseMsgDbRef =
        kFirebaseDbRef.child('messages/${now.year}/${now.month}/${now.day}');
    kFirebaseAuth.currentUser().then(
          (user) => setState(() {
            this._user = user;
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(Icons.info),
          onPressed: () => _showNoteDialog(context),
        ),
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(_user == null
              ? 'Chatting'
              : 'Chatting as "${_user.displayName}"'),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            _buildMessagesList(),
            Divider(height: 2.0),
            _buildComposeMsgRow()
          ],
        ),
      ),
    );
  }

  void _showNoteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Note'),
        content: Text('This chat room is for gaining more informations n the trip you want to go.In any of the time if you feel conforming the trip you can log with your email.'),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () => Navigator.of(ctx).pop(),
          )
        ],
      ),
    );
  }

  // Builds the list of chat messages.
  Widget _buildMessagesList() {
    return Flexible(
      child: Scrollbar(
        child: FirebaseAnimatedList(
          query: _firebaseMsgDbRef,
          sort: (a, b) => b.key.compareTo(a.key),
          padding: EdgeInsets.all(8.0),
          reverse: true,
          itemBuilder: (BuildContext ctx, DataSnapshot snapshot,
                  Animation<double> animation, int idx) =>
              _messageFromSnapshot(snapshot, animation),
        ),
      ),
    );
  }

  // Returns the UI of one message from a data snapshot.
  Widget _messageFromSnapshot(
      DataSnapshot snapshot, Animation<double> animation) {
    final String senderName = snapshot.value['senderName'] ?? '?? <unknown>';
    final String msgText = snapshot.value['text'] ?? '??';
    final sentTime = snapshot.value['timestamp'] ?? '<unknown timestamp>';
    final String senderPhotoUrl = snapshot.value['senderPhotoUrl'];
    final messageUI = Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: senderPhotoUrl != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(senderPhotoUrl),
                  )
                : CircleAvatar(
                    child: Text(senderName[0]),
                  ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(senderName, style: Theme.of(context).textTheme.subhead),
                Text(
                  DateTime.fromMillisecondsSinceEpoch(sentTime).toString(),
                  style: Theme.of(context).textTheme.caption,
                ),
                Text(msgText),
              ],
            ),
            ),
      ],
    ),
    );
    return SizeTransition(
      sizeFactor: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      axisAlignment: 0.0,
      child: messageUI,
    );
  }

  // Builds the row for composing and sending message.
  Widget _buildComposeMsgRow() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      color: Theme.of(context).cardColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Flexible(
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              maxLength: 200,
              decoration: InputDecoration.collapsed(hintText: "Send a message",enabled: true,hasFloatingPlaceholder: true),
              controller: _textController,
              onChanged: (String text) =>
                  setState(() => _isComposing = text.length > 0),
              onSubmitted: _onTextMsgSubmitted,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send,color: Colors.teal,),
            onPressed: _isComposing
                ? () => _onTextMsgSubmitted(_textController.text)
                : null,
          ),
        ],
      ),
    );
  }

  // Triggered when text is submitted (send button pressed).
  Future<Null> _onTextMsgSubmitted(String text) async {
    if (this._user == null) {
      this._user = await kFirebaseAuth.currentUser();
    }
    if (this._user == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Login required'),
          content: Text('To send messages you need to first log in.\n\n'
              'Go to the "Firebase login" example, and log in from there. '
              'You will then be able to send messages.'),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(ctx).pop(),
            )
          ],
        ),
      );
      return;
    }
    // Clear input text field.
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
    // Send message to firebase realtime database.
    _firebaseMsgDbRef.push().set({
      'senderId': this._user.uid,
      'senderName': this._user.displayName,
      'senderPhotoUrl': this._user.photoUrl,
      'text': text,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });

  }
}