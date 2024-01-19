import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tasorderan/bloc/home/chat/chat_bloc.dart';
import 'package:tasorderan/components/components.dart';
import 'package:tasorderan/core/api_client.dart';
import 'package:tasorderan/core/session_manager.dart';
import 'package:tasorderan/models/home_models.dart';
import 'package:tasorderan/repo/home_repository.dart';

class HubungiKamiDetail extends StatefulWidget {
  const HubungiKamiDetail({
    Key? key,
  }) : super(key: key);
  @override
  State<HubungiKamiDetail> createState() => _HubungiKamiDetailState();
}

class _HubungiKamiDetailState extends State<HubungiKamiDetail> {
  String? messageText;
  String? username;
  String? email;
  String? documentId;
  String? cabang;
  String? param;
  String? fcmToken;

  TextEditingController chatMsgTextController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final components = Tools();
  final apiClient = ApiClient();
  final sessionManager = SessionManager();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      documentId = args['documentId'];
      cabang = args['cabang'];
      param = args['param'].toString();
      fcmToken = args['fcmToken'];
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    // if (globals.loggedIn == false) {
                    //   showDialog<String>(
                    //       context: context,
                    //       builder: (context) {
                    //         return AlertDialog(
                    //           title: Text(
                    //             "Apakah anda yakin?",
                    //             style: TextStyle(fontWeight: FontWeight.bold),
                    //           ),
                    //           content: const Text(
                    //               'Apakah anda yakin? chat akan otomatis terhapus dan tidak akan menyimpan histori anda.'),
                    //           actions: <Widget>[
                    //             TextButton(
                    //               onPressed: () =>
                    //                   Navigator.pop(context, 'Cancel'),
                    //               child: const Text('Cancel'),
                    //             ),
                    //             TextButton(
                    //               onPressed: () async {
                    //                 await Navigator.pop(context, 'Ok');
                    //                 Navigator.of(context).pop();
                    //               },
                    //               child: const Text('OK'),
                    //             ),
                    //           ],
                    //         );
                    //       });
                    // } else {
                    Navigator.pop(context);
                    // }
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                const CircleAvatar(
                  backgroundImage: AssetImage("assets/imgs/user.png"),
                  maxRadius: 20,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        cabang!,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Online",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 212, 212, 212),
      body: BlocProvider(
        create: (context) => ChatBloc(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Material(
                color: const Color.fromARGB(255, 212, 212, 212),
                child: StreamBuilder(
                  stream: apiClient.firestore
                      .collection('conversations')
                      .doc(documentId)
                      .collection('messages')
                      .orderBy('timestamp', descending: false)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      final messages = snapshot.data!.docs;
                      List<ChatMessage> messageWidgets = [];
                      for (var message in messages) {
                        final msgText = message['message'];
                        final msgSender = message['sender'];
                        final currentUser =
                            sessionManager.anyActiveSession() == true
                                ? sessionManager.getActiveEmail()
                                : param;
                        final dataTimestamp = message['timestamp'];

                        // print('MSG'+msgSender + '  CURR'+currentUser);
                        final msgBubble = ChatMessage(
                          msgText: msgText,
                          msgSender: msgSender.toString(),
                          user: currentUser == msgSender,
                          timestamp: dataTimestamp,
                        );
                        messageWidgets.add(msgBubble);
                      }
                      return ListView.builder(
                        itemCount: messageWidgets.length + 1,
                        controller: _scrollController,
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        // physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (index == messageWidgets.length) {
                            return Container(
                              height: 70,
                            );
                          }
                          var dt = DateTime.fromMillisecondsSinceEpoch(
                              messageWidgets[index].timestamp);
                          var dateformat = DateFormat('dd MMM yyyy').format(dt);

                          bool visible = false;
                          if (index == 0) {
                            visible = true;
                          } else {
                            var timeStampitemBefore =
                                messageWidgets[index - 1].timestamp;
                            var dtTimestamp =
                                DateTime.fromMicrosecondsSinceEpoch(
                                    timeStampitemBefore * 1000);
                            var dtResultFormat =
                                DateFormat('dd MMM yyyy').format(dtTimestamp);
                            if (dateformat != dtResultFormat) {
                              visible = true;
                            }
                          }

                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                if (visible)
                                  Text(
                                    DateFormat('dd MMM yyyy').format(dt),
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontFamily: 'Poppins',
                                        color: Colors.black87),
                                    textAlign: TextAlign.right,
                                  ),
                                Align(
                                  alignment: messageWidgets[index].user
                                      ? Alignment.bottomRight
                                      : Alignment.bottomLeft,
                                  child: Container(
                                    width: 300,
                                    padding: const EdgeInsets.only(
                                        left: 14,
                                        right: 14,
                                        top: 10,
                                        bottom: 10),
                                    child: Align(
                                      alignment: (messageWidgets[index].user
                                          ? Alignment.topRight
                                          : Alignment.topLeft),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: (messageWidgets[index].user
                                              ? Colors.blue[200]
                                              : Colors.grey.shade200),
                                        ),
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              messageWidgets[index].msgText,
                                              style:
                                                  const TextStyle(fontSize: 15),
                                            ),
                                            Text(
                                              DateFormat('HH:mm').format(dt),
                                              textAlign: TextAlign.right,
                                              style:
                                                  const TextStyle(fontSize: 11),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Material(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 8.0, top: 2, bottom: 2),
                        child: TextField(
                          onChanged: (value) {
                            messageText = value;
                          },
                          controller: chatMsgTextController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 20.0,
                            ),
                            hintText: 'Ketik Pesan',
                            hintStyle: TextStyle(
                              fontFamily: 'Nunito-Medium',
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  MaterialButton(
                    shape: const CircleBorder(),
                    color: Colors.blue,
                    onPressed: () async {
                      Map<String, dynamic> dataChat = {
                        'message': messageText,
                        'read': false,
                        'senderName': sessionManager.anyActiveSession() == true
                            ? sessionManager.getActiveName()
                            : "Guest",
                        'sender': sessionManager.anyActiveSession() == true
                            ? sessionManager.getActiveEmail()
                            : param,
                        'timestamp': DateTime.now().millisecondsSinceEpoch,
                      };
                      _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut);
                      apiClient.firestore
                          .collection('conversations')
                          .doc(documentId)
                          .collection('messages')
                          .doc()
                          .set(dataChat);
                      Map<String, dynamic> params = {
                        "fcmToken": fcmToken,
                        "senderName": sessionManager.anyActiveSession() == true
                            ? sessionManager.getActiveName()
                            : "GUEST ($param)",
                        "messageSender": messageText,
                      };
                      await HomeRepository().sendMessage(params);
                      chatMsgTextController.clear();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                    // Text(
                    //   'Send',
                    //   style: kSendButtonTextStyle,
                    // ),
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
