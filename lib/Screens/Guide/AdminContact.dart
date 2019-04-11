import 'package:flutter/material.dart';

class AdminContact extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact with admin"),
      ),
      body: Container(
        height: 300.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                child: Text("1"),
                backgroundColor: Colors.black,
              ),
              title: Text("Conversation 1"),
              trailing: Icon(Icons.insert_emoticon,color: Colors.black,),
            ),
            ListTile(
              leading: CircleAvatar(
                child: Text("2"),
                backgroundColor: Colors.black,
              ),
              title: Text("Conversation 2"),
              trailing: Icon(Icons.insert_emoticon,color: Colors.black,),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Column(
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: (){},
                    child: Icon(Icons.add),
                    backgroundColor: Colors.black,

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