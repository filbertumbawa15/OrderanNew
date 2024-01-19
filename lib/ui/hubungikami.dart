import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasorderan/bloc/home/chat/chat_bloc.dart';
import 'package:tasorderan/components/components.dart';
import 'package:tasorderan/core/api_client.dart';
import 'package:tasorderan/core/session_manager.dart';
import 'package:tasorderan/models/home_models.dart';

class HubungiKami extends StatefulWidget {
  const HubungiKami({super.key});

  @override
  State<HubungiKami> createState() => _HubungiKamiState();
}

class _HubungiKamiState extends State<HubungiKami> {
  // bool isMessageRead;
  List<ChatUsers> chatUsers = [
    ChatUsers(
      name: "Medan",
      messageText: "Hubungi Cabang Medan",
      imageURL: "assets/imgs/user.png",
      time: "Now",
      email: "transporindo.medan110402@gmail.com",
    ),
    ChatUsers(
      name: "Jakarta",
      messageText: "Hubungi Cabang Medan",
      imageURL: "assets/imgs/user.png",
      time: "Now",
      email: "",
    ),
    ChatUsers(
      name: "Surabaya",
      messageText: "Hubungi Cabang Medan",
      imageURL: "assets/imgs/user.png",
      time: "Now",
      email: "",
    ),
    ChatUsers(
      name: "Makassar",
      messageText: "Hubungi Cabang Medan",
      imageURL: "assets/imgs/user.png",
      time: "Now",
      email: "",
    ),
  ];
  String? username;
  String? email;
  String? messageText;
  SharedPreferences? prefsTimestamp;
  final sessionManager = SessionManager();
  final apiClient = ApiClient();
  final components = Tools();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ChatBloc(),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 16, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                        ),
                      ),
                      const Text(
                        "Chats",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Container(),
                    ],
                  ),
                ),
              ),
              BlocConsumer<ChatBloc, ChatState>(
                listener: (context, state) {
                  if (state is ChatSuccess) {
                    print(state.result);
                    Navigator.pushNamed(
                      context,
                      '/hubungi_kami_detail',
                      arguments: {
                        'documentId': state.result["documentId"],
                        'cabang': state.result["cabang"],
                        'param': state.result["param"],
                        'fcmToken': state.result["fcmToken"],
                        'uidParam': state.result["uidParam"],
                      },
                    );
                  } else if (state is ChatFailed) {
                    print(state.message);
                  }
                },
                builder: (context, state) {
                  return StreamBuilder(
                      stream:
                          apiClient.firestore.collection('users').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(top: 16),
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  print(sessionManager.anyActiveSession());
                                  if (sessionManager.anyActiveSession() ==
                                      true) {
                                    context
                                        .read<ChatBloc>()
                                        .add(StartChatEventLogin(
                                          email: snapshot.data!.docs[index]
                                              ['email'],
                                          username: snapshot.data!.docs[index]
                                              ['username'],
                                          fcmToken: snapshot.data!.docs[index]
                                              ['fcmToken'],
                                        ));
                                  } else {
                                    context
                                        .read<ChatBloc>()
                                        .add(StartChatEventNotLogin(
                                          email: snapshot.data!.docs[index]
                                              ['email'],
                                          username: snapshot.data!.docs[index]
                                              ['username'],
                                          fcmToken: snapshot.data!.docs[index]
                                              ['fcmToken'],
                                        ));
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16, top: 10, bottom: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Row(
                                          children: <Widget>[
                                            CircleAvatar(
                                              backgroundImage: AssetImage(
                                                chatUsers[index].imageURL,
                                              ),
                                              maxRadius: 30,
                                            ),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Expanded(
                                              child: Container(
                                                color: Colors.transparent,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      snapshot.data!.docs[index]
                                                          ['username'],
                                                      style: const TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                    const SizedBox(
                                                      height: 6,
                                                    ),
                                                    Text(
                                                      "Hubungi ${snapshot.data!.docs[index]['username']}",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors
                                                              .grey.shade600,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Text(
                                        "Online",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(snapshot.error.toString()),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
