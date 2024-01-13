// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dropdown_search/dropdown_search.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// // import 'package:now_ui_flutter/models/dart_models.dart';
// // import 'package:now_ui_flutter/providers/services.dart';
// // import 'package:now_ui_flutter/screens/Chats/chat_detail.dart';
// // import 'package:now_ui_flutter/globals.dart' as globals;
// // import 'package:provider/provider.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
// import 'package:tasorderan/models/home_models.dart';

// class Chats extends StatefulWidget {
//   const Chats({super.key});

//   @override
//   State<Chats> createState() => _ChatsState();
// }

// class _ChatsState extends State<Chats> {
//   // bool isMessageRead;
//   List<ChatUsers> chatUsers = [
//     ChatUsers(
//       name: "Medan",
//       messageText: "Hubungi Cabang Medan",
//       imageURL: "assets/imgs/user.png",
//       time: "Now",
//       email: "transporindo.medan110402@gmail.com",
//     ),
//     ChatUsers(
//       name: "Jakarta",
//       messageText: "Hubungi Cabang Medan",
//       imageURL: "assets/imgs/user.png",
//       time: "Now",
//       email: "",
//     ),
//     ChatUsers(
//       name: "Surabaya",
//       messageText: "Hubungi Cabang Medan",
//       imageURL: "assets/imgs/user.png",
//       time: "Now",
//       email: "",
//     ),
//     ChatUsers(
//       name: "Makassar",
//       messageText: "Hubungi Cabang Medan",
//       imageURL: "assets/imgs/user.png",
//       time: "Now",
//       email: "",
//     ),
//   ];

//   final _firestore = FirebaseFirestore.instance;
//   String? username;
//   String? email;
//   String? messageText;
//   User loggedInUser;
//   SimpleFontelicoProgressDialog _dialog;
//   SharedPreferences prefsTimestamp;

//   @override
//   void initState() {
//     super.initState();
//   }

//   Future<void> openChat(String email, String name, String fcmTokenAdmin) async {
//     _showDialog(context, SimpleFontelicoProgressDialogType.normal, 'Normal');
//     print("A");
//     final test = _firestore
//         .collection('conversations')
//         .where('participants', isEqualTo: [email, globals.loggedinEmail]);
//     final snapshot = await test.get();
//     print("B");
//     if (snapshot.docs.length > 0) {
//       await _firestore
//           .collection('conversations')
//           .doc('$email||${globals.loggedinEmail}')
//           .update({
//         'fcmToken': globals.fcmToken,
//       });
//       print("C");
//       _dialog.hide();
//       await Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: ((context) => ChatDetail(
//                     documentId: snapshot.docs[0].id,
//                     cabang: name,
//                     fcmToken: fcmTokenAdmin,
//                     uidParam: snapshot.docs[0]['uid'],
//                   ))));
//     } else {
//       int timestamp = DateTime.now().millisecondsSinceEpoch;
//       List<Object> array = [email, globals.loggedinEmail];
//       Map<String, Object> data = {
//         "uid": timestamp,
//         "participants": array,
//         "user": globals.loggedinName,
//         "fcmToken": globals.fcmToken,
//       };
//       Map<String, Object> chatData = {
//         'message': "Kami dari Shipper Transporindo ingin menanyakan sesuatu",
//         'senderName': globals.loggedinName,
//         'sender': globals.loggedinEmail,
//         'timestamp': DateTime.now().millisecondsSinceEpoch,
//       };
//       print("D");
//       final CollectionReference parentCollection =
//           _firestore.collection('conversations');
//       // Future.delayed(const Duration(seconds: 2), () async {
//       await parentCollection.doc('$email||${globals.loggedinEmail}').set(data);
//       final QuerySnapshot dataChats = await parentCollection
//           .doc('$email||${globals.loggedinEmail}')
//           .collection('messages')
//           .get();
//       if (dataChats.docs.length == 0) {
//         await parentCollection
//             .doc('$email||${globals.loggedinEmail}')
//             .collection('messages')
//             .doc()
//             .set(chatData);
//         Provider.of<MasterProvider>(context, listen: false)
//             .storeConversation(data, array, chatData, timestamp);
//         // Provider.of<MasterProvider>(context, listen: false)
//         //     .storeChat(chatData, timestamp);
//       }
//       final test = _firestore
//           .collection('conversations')
//           .where('participants', isEqualTo: array);
//       final snapshot = await test.get();
//       _dialog.hide();
//       await Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: ((context) => ChatDetail(
//                     documentId: snapshot.docs[0].id,
//                     cabang: name,
//                     fcmToken: fcmTokenAdmin,
//                     uidParam: snapshot.docs[0]['uid'],
//                   ))));
//     }
//   }

//   Future<void> openChatLogin(
//       String email, String name, String fcmTokenAdmin) async {
//     _showDialog(context, SimpleFontelicoProgressDialogType.normal, 'Normal');
//     prefsTimestamp = await SharedPreferences.getInstance();
//     int timestamp;
//     final CollectionReference parentCollection =
//         _firestore.collection('conversations');
//     print(prefsTimestamp.getString('chatsTimestamp'));
//     if (prefsTimestamp.getString('chatsTimestamp') == null) {
//       int timestamp = DateTime.now().millisecondsSinceEpoch;
//       List<Object> array = [email, timestamp];
//       Map<String, Object> data = {
//         'uid': timestamp,
//         'participants': array,
//         "user": timestamp,
//         'fcmToken': globals.fcmToken,
//       };
//       Map<String, Object> chatData = {
//         'message':
//             "Selamat datang di Aplikasi Orderan Transporindo. Ada yang bisa kami bantu?",
//         'senderName': name,
//         'sender': email,
//         'timestamp': DateTime.now().millisecondsSinceEpoch,
//       };
//       timestamp = DateTime.now().millisecondsSinceEpoch;
//       prefsTimestamp.setString('chatsTimestamp', timestamp.toString());
//       await parentCollection.doc('$email||$timestamp').set(data);

//       await parentCollection
//           .doc('$email||$timestamp')
//           .collection('messages')
//           .doc()
//           .set(chatData);

//       Provider.of<MasterProvider>(context, listen: false)
//           .storeConversation(data, array, chatData, timestamp);
//       // Provider.of<MasterProvider>(context, listen: false)
//       //     .storeChat(chatData, timestamp);
//       final test = _firestore
//           .collection('conversations')
//           .where('participants', isEqualTo: array);
//       final snapshot = await test.get();
//       _dialog.hide();
//       await Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: ((context) => ChatDetail(
//                     documentId: snapshot.docs[0].id,
//                     cabang: name,
//                     param: timestamp,
//                     fcmToken: fcmTokenAdmin,
//                     uidParam: timestamp,
//                   ))));
//     } else {
//       timestamp = int.parse(prefsTimestamp.getString('chatsTimestamp'));
//       List<Object> array = [email, timestamp];
//       print(array.toString());
//       final checkData =
//           _firestore.collection('conversations').doc('$email||$timestamp');

//       checkData.get().then((docData) async {
//         if (docData.exists) {
//           print("Baca exists");
//           final test = _firestore
//               .collection('conversations')
//               .where('participants', isEqualTo: array);
//           await _firestore
//               .collection('conversations')
//               .doc('$email||$timestamp')
//               .update({
//             'fcmToken': globals.fcmToken,
//           });
//           final snapshot = await test.get();
//           _dialog.hide();
//           await Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: ((context) => ChatDetail(
//                         documentId: snapshot.docs[0].id,
//                         cabang: name,
//                         param: timestamp,
//                         fcmToken: fcmTokenAdmin,
//                         uidParam: timestamp,
//                       ))));
//         } else {
//           print("Brarti tambah dokumen dlu");
//           Map<String, Object> data = {
//             'uid': timestamp,
//             'participants': array,
//             "user": timestamp,
//             'fcmToken': globals.fcmToken,
//           };
//           Map<String, Object> chatData = {
//             'message':
//                 "Selamat datang di Aplikasi Orderan Transporindo. Ada yang bisa kami bantu?",
//             'senderName': name,
//             'sender': email,
//             'timestamp': DateTime.now().millisecondsSinceEpoch,
//           };
//           await parentCollection.doc('$email||$timestamp').set(data);

//           await parentCollection
//               .doc('$email||$timestamp')
//               .collection('messages')
//               .doc()
//               .set(chatData);

//           Provider.of<MasterProvider>(context, listen: false)
//               .storeConversation(data, array, chatData, timestamp);
//           // Provider.of<MasterProvider>(context, listen: false)
//           //     .storeChat(chatData, timestamp);
//           final test = _firestore
//               .collection('conversations')
//               .where('participants', isEqualTo: array);
//           final snapshot = await test.get();
//           _dialog.hide();
//           await Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: ((context) => ChatDetail(
//                         documentId: snapshot.docs[0].id,
//                         cabang: name,
//                         param: timestamp,
//                         fcmToken: fcmTokenAdmin,
//                         uidParam: timestamp,
//                       ))));
//         }
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         physics: BouncingScrollPhysics(),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             SafeArea(
//               child: Padding(
//                 padding: EdgeInsets.only(left: 10, right: 16, top: 10),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: Icon(
//                         Icons.arrow_back,
//                       ),
//                     ),
//                     Text(
//                       "Chats",
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     Container(),
//                   ],
//                 ),
//               ),
//             ),
//             StreamBuilder(
//                 stream: _firestore.collection('users').snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     return ListView.builder(
//                       itemCount: snapshot.data.docs.length,
//                       shrinkWrap: true,
//                       padding: EdgeInsets.only(top: 16),
//                       physics: NeverScrollableScrollPhysics(),
//                       itemBuilder: (context, index) {
//                         return GestureDetector(
//                           onTap: () {
//                             if (globals.loggedIn == false) {
//                               openChatLogin(
//                                 snapshot.data.docs[index]['email'],
//                                 snapshot.data.docs[index]['username'],
//                                 snapshot.data.docs[index]['fcmToken'],
//                               );
//                             } else {
//                               openChat(
//                                 snapshot.data.docs[index]['email'],
//                                 snapshot.data.docs[index]['username'],
//                                 snapshot.data.docs[index]['fcmToken'],
//                               );
//                             }
//                           },
//                           child: Container(
//                             padding: EdgeInsets.only(
//                                 left: 16, right: 16, top: 10, bottom: 10),
//                             child: Row(
//                               children: <Widget>[
//                                 Expanded(
//                                   child: Row(
//                                     children: <Widget>[
//                                       CircleAvatar(
//                                         backgroundImage: AssetImage(
//                                           chatUsers[index].imageURL,
//                                         ),
//                                         maxRadius: 30,
//                                       ),
//                                       SizedBox(
//                                         width: 16,
//                                       ),
//                                       Expanded(
//                                         child: Container(
//                                           color: Colors.transparent,
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: <Widget>[
//                                               Text(
//                                                 snapshot.data.docs[index]
//                                                     ['username'],
//                                                 style: TextStyle(fontSize: 16),
//                                               ),
//                                               SizedBox(
//                                                 height: 6,
//                                               ),
//                                               Text(
//                                                 "Hubungi ${snapshot.data.docs[index]['username']}",
//                                                 style: TextStyle(
//                                                     fontSize: 13,
//                                                     color: Colors.grey.shade600,
//                                                     fontWeight:
//                                                         FontWeight.normal),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Text(
//                                   chatUsers[index].time,
//                                   style: TextStyle(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.normal),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   }
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showDialog(BuildContext context, SimpleFontelicoProgressDialogType type,
//       String text) async {
//     if (_dialog == null) {
//       _dialog = SimpleFontelicoProgressDialog(
//           context: context, barrierDimisable: false);
//     }
//     if (type == SimpleFontelicoProgressDialogType.custom) {
//       _dialog.show(
//           message: text,
//           type: type,
//           width: 150.0,
//           height: 75.0,
//           loadingIndicator: Text(
//             'C',
//             style: TextStyle(fontSize: 24.0),
//           ));
//     } else {
//       _dialog.show(
//           message: text,
//           type: type,
//           horizontal: true,
//           width: 150.0,
//           height: 75.0,
//           hideText: true,
//           indicatorColor: Colors.blue);
//     }
//   }

//   Widget asdf() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 10),
//       child: SizedBox(
//         height: 40,
//         child: DropdownSearch<String>(
//           showAsSuffixIcons: true,
//           mode: Mode.BOTTOM_SHEET,
//           dropdownSearchDecoration: InputDecoration(
//             labelText: "Kota Pelabuhan",
//             contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
//             border: OutlineInputBorder(),
//           ),
//           showSearchBox: true,
//           searchFieldProps: TextFieldProps(
//             decoration: InputDecoration(
//               border: OutlineInputBorder(),
//               contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
//               labelText: "Cari Pelabuhan",
//             ),
//           ),
//           popupTitle: Container(
//             height: 50,
//             decoration: BoxDecoration(
//               color: Theme.of(context).primaryColorDark,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(0),
//                 topRight: Radius.circular(0),
//               ),
//             ),
//             child: Center(
//               child: Text(
//                 'Pelabuhan',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//           popupShape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(0),
//               topRight: Radius.circular(0),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
