import 'dart:async';
import 'dart:io';
import 'auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'chatscreen.dart';
import 'const.dart';
import 'msglogin.dart';
import 'settings.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'login.dart';
import 'colors.dart';

// void main() => runApp(new MyApp());

// PS 3/7
// Auth firebaseAuth;
// String tmpID = "7j05qHZ9RXVIpYNphE7c";
const String currentUserId = "7j05qHZ9RXVIpYNphE7c";

class MsgMain extends StatefulWidget {
  // final String currentUserId;
  final BaseAuth auth;
  // MainScreen({Key key, this.currentUserId}) : super(key: key);
  MsgMain({this.auth});

  @override
  // State createState() => new MainScreenState(currentUserId: currentUserId);
  MsgMainState createState() => new MsgMainState();
}

class MsgMainState extends State<MsgMain> {
  bool isLoading = false;
  List<Choice> choices = const <Choice>[
      const Choice(title: 'Settings', icon: Icons.settings),
 
  ];


// class MainScreenState extends State<MainScreen> {
//   MainScreenState({Key key, @required this.currentUserId});

//   final String currentUserId;

//   bool isLoading = false;
//   List<Choice> choices = const <Choice>[
//     const Choice(title: 'Settings', icon: Icons.settings),
//     // const Choice(title: 'Log out', icon: Icons.exit_to_app),
//   ];


  //  Future<bool> onBackPress() {
  //    openDialog();
  //    return Future.value(false);
  //  }  


  // Future<Null> openDialog() async {
  //   switch (await showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return SimpleDialog(
  //           contentPadding:
  //           EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
  //           children: <Widget>[
  //             Container(
  //               color: themeColor,
  //               margin: EdgeInsets.all(0.0),
  //               padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
  //               height: 100.0,
  //               child: Column(
  //                 children: <Widget>[
  //                   Container(
  //                     child: Icon(
  //                       Icons.exit_to_app,
  //                       size: 30.0,
  //                       color: Colors.white,
  //                     ),
  //                     margin: EdgeInsets.only(bottom: 10.0),
  //                   )
  //                   // Text(
  //                   //   'Exit app',
  //                   //   style: TextStyle(
  //                   //       color: Colors.white,
  //                   //       fontSize: 18.0,
  //                   //       fontWeight: FontWeight.bold),
  //                   // ),
  //                   // Text(
  //                   //   'Are you sure to exit app?',
  //                   //   style: TextStyle(color: Colors.white70, fontSize: 14.0),
  //                   // ),
  //                 ],
  //               ),
  //             ),
  //             SimpleDialogOption(
  //               onPressed: () {
  //                 Navigator.pop(context, 0);
  //               },
  //               child: Row(
  //                 children: <Widget>[
  //                   Container(
  //                     child: Icon(
  //                       Icons.cancel,
  //                       color: primaryColor,
  //                     ),
  //                     margin: EdgeInsets.only(right: 10.0),
  //                   ),
  //                   // Text(
  //                   //   'CANCEL',
  //                   //   style: TextStyle(
  //                   //       color: primaryColor, fontWeight: FontWeight.bold),
  //                   // )
  //                 ],
  //               ),
  //             ),
  //             // SimpleDialogOption(
  //             //   onPressed: () {
  //             //     Navigator.pop(context, 1);
  //             //   },
  //             //   child: Row(
  //             //     children: <Widget>[
  //             //       Container(
  //             //         child: Icon(
  //             //           Icons.check_circle,
  //             //           color: primaryColor,
  //             //         ),
  //             //         margin: EdgeInsets.only(right: 10.0),
  //             //       ),
  //             //       Text(
  //             //         'YES',
  //             //         style: TextStyle(
  //             //             color: primaryColor, fontWeight: FontWeight.bold),
  //             //       )
  //             //     ],
  //             //   ),
  //             // ),
  //           ],
  //         );
  //       })) {
  //     // case 0:
  //     //   break;
  //     // case 1:
  //     //   exit(0);
  //     //   break;
  //   }
  // }

// Future<FirebaseUser> firebaseUser = FirebaseAuth.instance.currentUser();
// String currentUserId = firebaseUser;
 Future<FirebaseUser> firebaseUser =  FirebaseAuth.instance.currentUser();

// Auth firebaseAuth;
// Future<String> currentUserId = firebaseAuth.currentUser();
  Widget buildItem(BuildContext context, DocumentSnapshot document) {
    
    // if (null !=  FirebaseAuth.instance.currentUser())
    // {
    //   debugPrint("********************************");
    // }

    if (document['userID'] == FirebaseAuth.instance.currentUser()){
      return Container();
    } else {
      return Container(
        child: FlatButton(
          child: Row(
            children: <Widget>[
              Material(
                child: CachedNetworkImage(
                  placeholder: Container(
                    child: CircularProgressIndicator(
                      strokeWidth: 1.0,
                      valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                    ),
                    width: 50.0,
                    height: 50.0,
                    padding: EdgeInsets.all(15.0),
                  ),
                  imageUrl: document['photoUrl'],
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                clipBehavior: Clip.hardEdge,
              ),
              new Flexible(
                child: Container(
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        child: Text(
                          'Nickname: ${document['last name']}',
                          style: TextStyle(color: primaryColor),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: new EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                      ),
                      new Container(
                        child: Text(
                          'About me: ${document['aboutMe'] ?? 'Not available'}',
                          style: TextStyle(color: primaryColor),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: new EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                      )
                    ],
                  ),
                  margin: EdgeInsets.only(left: 20.0),
                ),
              ),
            ],
          ),
          onPressed: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new Chat(
                      peerId: document.documentID,
                      peerAvatar: document['photoUrl'],
                    )));
          },
          color: greyColor2,
          padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
      );
    }
  }

  void onItemMenuPress(Choice choice) {
    // if (choice.title == 'Log out') {
    //   handleSignOut();
    // } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Settings()));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     // 'MAIN',
      //     currentUserId,
      //     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      //   ),
      //   centerTitle: true,
      //   actions: <Widget>[
      //     PopupMenuButton<Choice>(
      //       onSelected: onItemMenuPress,
      //       itemBuilder: (BuildContext context) {
      //         return choices.map((Choice choice) {
      //           return PopupMenuItem<Choice>(
      //               value: choice,
      //               child: Row(
      //                 children: <Widget>[
      //                   Icon(
      //                     choice.icon,
      //                     color: primaryColor,
      //                   ),
      //                   Container(
      //                     width: 10.0,
      //                   ),
      //                   Text(
      //                     choice.title,
      //                     style: TextStyle(color: primaryColor),
      //                   ),
      //                 ],
      //               ));
      //         }).toList();
      //       },
      //     ),
      //   ],
      // ),
      body: WillPopScope(
        child: Stack(
          children: <Widget>[
            // List
            Container(
              child: StreamBuilder(
                stream: Firestore.instance.collection('users').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {  
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      padding: EdgeInsets.all(10.0),
                      itemBuilder: (context, index) =>
                          buildItem(context, snapshot.data.documents[index]),
                      itemCount: snapshot.data.documents.length,
                    );
                  }
                },
              ),
            ),

            // Loading
            Positioned(
              child: isLoading
                  ? Container(
                child: Center(
                  child: CircularProgressIndicator(
                      valueColor:
                      AlwaysStoppedAnimation<Color>(themeColor)),
                ),
                color: Colors.white.withOpacity(0.8),
              )
                  : Container(),
            )
          ],
        ),
          //  onWillPop: onBackPress,
          onWillPop:null,
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}