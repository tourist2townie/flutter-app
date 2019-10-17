import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:tt/utils/ResponseData.dart';

import 'Chatting.dart';
String apiUrl ="http://10.0.2.2:8000/api/tripStatusUpdate/${ResponseData.onGoingTripId}";

class userDetails{
  final String providerDetail;
  final String userName;
  final String photoUrl;
  final String userEmail;
  final List<ProviderDetails> providerData;
  userDetails(this.providerDetail,this.userName,this.photoUrl,this.userEmail,this.providerData);

}

class ProviderDetails{
  ProviderDetails(this.providerDetails);
  final String providerDetails;
}

class Chatroom extends StatefulWidget {
  @override
  _ChatroomState createState() => _ChatroomState();
}

class _ChatroomState extends State<Chatroom> {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseUser user;

//Google login
  Future<FirebaseUser> _signIn(BuildContext context) async{
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );

    FirebaseUser userCredentials = await _firebaseAuth.signInWithCredential(credential);
    ProviderDetails providerInfo = ProviderDetails(userCredentials.providerId);

    List<ProviderDetails> providerData = List<ProviderDetails>();
    providerData.add(providerInfo);

    userDetails details = new userDetails(userCredentials.providerId,userCredentials.displayName,userCredentials.photoUrl,userCredentials.email,providerData);

    Navigator.push(context, MaterialPageRoute(
      builder: (context)=>Chatting(),

    ));
    return userCredentials;
  }

   Future _signOut() async {
    await _firebaseAuth.signOut();
    _googleSignIn.signOut();
  }

  void editTriptatus(){
  http.put(apiUrl,
      headers: {
        'Accept':'application/json',
        'Authorization' : 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjliNTg2MWVlNTg0ZGJkZGI5MDc1NDc3YTQ1ZDQ3ZDM5NGNiMzU2ZGIxZjBhMjUwZDUyZjk0YmViNGQwOTM3NTI0ZTM0MGNhMzBiYWM5NDAwIn0.eyJhdWQiOiIxIiwianRpIjoiOWI1ODYxZWU1ODRkYmRkYjkwNzU0NzdhNDVkNDdkMzk0Y2IzNTZkYjFmMGEyNTBkNTJmOTRiZWI0ZDA5Mzc1MjRlMzQwY2EzMGJhYzk0MDAiLCJpYXQiOjE1NTg1NTMyMTMsIm5iZiI6MTU1ODU1MzIxMywiZXhwIjoxNTkwMTc1NjEzLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.sFIfXVx72efT54J40TVkqh3rwMGW-anTulNMDnVvGh_eO_qz0oKRl56JYCBwPQchc7fTbG5ZkVwaf_oU85rzjq3hrgXaOIzOoaNYsAKTOpPVbPi26bqpMLCWFe26hZO3BmS_kCSSD_-WlYVOlEw5oXQt1_MHV1eBt0tbXFLkgNwvkFr9IOvySINVsDOVoCArvp2Cx-XYthIP-0JuC7yQny5byMKerRGDO8pIjKLnPTTi9YWo36KU1SlzqoK-IJrQFvi5ir-rKk93IFCXwNoRN9QwXATb_4uJJyhpv2WLtXQwpnlPFqQFad8L0I8y9pfyzXnDtl3Aq1G3OlZMHbKcXp4uV8uByuT7UzI_FW6a0ion3Id1P3wy65n-X2OW2rDH6cpoCaz5_yzkpUfeo5WQ0RpG7q_VbWon2rf2NpbV8Jyzg80Woz3eNaQPA8-hdR5qUeeGXXulwfcT_sQln2uBmC3Ke2gbI1cKrBa4gVFpip9055lhgXfKzBvNkhV2dUljawBGacb0p4C1irkz6ygTzMu_31r2KHuzXiKQvbaEmorHGOLdvrwr-L2cqUmM3_jeAMmrV2_Pe4nRJHsvOLOYpB6ELNdeX8_DhD7DWUa6pdeU2PpRsXvwaGLbAkah9z7hCa54HGCzSLJPhN813nTXHuK_biSxIlH5n3ruvHiP6Rw'
      },
      body: {
        "status" : "Ongoing",
      }).then((response){
        if(response.statusCode==200){
          Navigator.pop(context);
    print('Response status : ${response.statusCode}');
          Toast.show("Your trip started", context);
        }else{
          
    print('Response body : ${response.statusCode}');
        }
  });

    }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          RaisedButton(
        onPressed: (){_signIn(context).then((FirebaseUser user)=>print(user.uid)).catchError((e)=>print(e));},
        child: Text("Google btn"),
      ),
      RaisedButton(
        onPressed: (){
          _signOut();
        },
        child: Text("anomous login"),
      ),
      RaisedButton(
        onPressed: (){
          editTriptatus();
        },
        child: Text("Start trip"),
      )
        ],
      ),
    );
  }
}

