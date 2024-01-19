import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasorderan/core/api_client.dart';
import 'package:tasorderan/core/session_manager.dart';
import 'package:tasorderan/main.dart';
import 'package:tasorderan/params/home_params.dart';
import 'package:tasorderan/repo/pesanan_repository.dart';
import 'package:tasorderan/response/pesanan_response.dart';

class HomeRepository extends ApiClient {
  final sessionManager = SessionManager();
  final pesananRepository = PesananRepository();
  final apiClient = ApiClient();
  Future<String> cekValidasiPesanan() async {
    // try {
    if (sessionManager.getActiveId() == null) {
      throw jsonEncode({
        "message": "Silahkan Login terlebih dahulu",
        "content": "Masih belum berhasil",
        "images": "assets/imgs/updated-transaction.json",
      });
    } else {
      if (sessionManager.getActiveVerification() == "12" ||
          sessionManager.getActiveVerification() == "14" ||
          sessionManager.getActiveVerification() == "0") {
        throw jsonEncode({
          "message":
              "Anda belum menyelesaikan status verifikasi anda/belum login",
          "content": "Masih belum berhasil",
          "images": "assets/imgs/updated-transaction.json",
        });
      } else {
        final response = await pesananRepository.validasiOrderan();
        if (response["data"].isNotEmpty) {
          throw jsonEncode({
            "message":
                "Mohon selesaikan orderan awal terlebih dahulu agar dapat melanjutkan pemesanan kembali.",
            "content": "Orderan masih belum selesai",
            "images": "assets/imgs/shipping-truck.json",
          });
        }
      }
    }
    return "Berhasil";
  }

  Future<FavoriteResponse> listFavorites() async {
    try {
      final response = await dio.get(
          'orderemkl-api/public/api/favorites/${sessionManager.getActiveId() ?? 0}',
          options: Options(headers: {
            'Authorization': 'Bearer ${sessionManager.getActiveToken()}',
          }));
      return FavoriteResponse.fromJson(response.data["data"]);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> openChatNotLogin(ChatParams params) async {
    try {
      final prefsTimestamp = await SharedPreferences.getInstance();
      Map<String, dynamic>? resultData;
      final CollectionReference parentCollection =
          apiClient.firestore.collection('conversations');
      print(parentCollection);
      final getUsersData = await apiClient.firestore
          .collection('users')
          .where('email', isEqualTo: params.email)
          .get();
      if (prefsTimestamp.getString('chatsTimestamp') == null) {
        int timestamp = DateTime.now().millisecondsSinceEpoch;
        List<String> array = [params.email!, timestamp.toString()];
        Map<String, dynamic> data = {
          'uid': timestamp,
          'participants': array,
          'user': timestamp,
          'fcmToken': fcmToken,
        };
        Map<String, Object> chatData = {
          'message':
              "Selamat datang di Aplikasi Orderan Transporindo. kami ingin menanyakan sesuatu",
          'read': false,
          'senderName': "GUEST",
          'sender': timestamp.toString(),
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        };

        //Storing to firebase
        prefsTimestamp.setString('chatsTimestamp', timestamp.toString());
        await parentCollection.doc('${params.email}||$timestamp').set(data);
        await parentCollection
            .doc('${params.email}||$timestamp')
            .collection('messages')
            .doc()
            .set(chatData);

        final getChatData = apiClient.firestore
            .collection('conversations')
            .where('participants', isEqualTo: array);

        final snapshot = await getChatData.get();

        resultData = {
          'documentId': snapshot.docs[0].id,
          'cabang': params.username,
          'param': timestamp,
          'fcmToken': getUsersData.docs[0]['fcmToken'],
          'uidParam': timestamp,
        };
        await HomeRepository().sendMessage({
          "fcmToken": getUsersData.docs[0]['fcmToken'],
          "senderName": "GUEST ($timestamp)",
          "messageSender":
              "Selamat datang di Aplikasi Orderan Transporindo. kami ingin menanyakan sesuatu",
        });
      } else {
        print("sini sini");
        int timestamp = int.parse(prefsTimestamp.getString('chatsTimestamp')!);
        List<String> array = [params.email!, timestamp.toString()];

        final checkData = apiClient.firestore
            .collection('conversations')
            .doc('${params.email}||$timestamp');

        await checkData.get().then(
          (docData) async {
            print(docData);
            print("lempar sini");
            if (docData.exists) {
              final readData = apiClient.firestore
                  .collection('conversations')
                  .where('participants', isEqualTo: array);

              await apiClient.firestore
                  .collection('conversations')
                  .doc('${params.email}||$timestamp')
                  .update({
                'fcmToken': fcmToken,
              });

              final snapshot = await readData.get();

              resultData = {
                'documentId': snapshot.docs[0].id,
                'cabang': params.username,
                'param': timestamp,
                'fcmToken': getUsersData.docs[0]['fcmToken'],
                'uidParam': timestamp,
              };
              print("last minute");
            } else {
              print("baca else");
              Map<String, dynamic> data = {
                'uid': timestamp,
                'participants': array,
                "user": timestamp,
                'fcmToken': fcmToken,
              };
              Map<String, Object> chatData = {
                'message':
                    "Selamat datang di Aplikasi Orderan Transporindo. kami ingin menanyakan sesuatu",
                'read': false,
                'senderName': "GUEST",
                'sender': timestamp.toString(),
                'timestamp': DateTime.now().millisecondsSinceEpoch,
              };

              await parentCollection
                  .doc('${params.email}||$timestamp')
                  .set(data);

              await parentCollection
                  .doc('${params.email}||$timestamp')
                  .collection('messages')
                  .doc()
                  .set(chatData);

              final getData = apiClient.firestore
                  .collection('conversations')
                  .where('participants', isEqualTo: array);
              final snapshot = await getData.get();

              resultData = {
                'documentId': snapshot.docs[0].id,
                'cabang': params.username,
                'param': timestamp,
                'fcmToken': getUsersData.docs[0]['fcmToken'],
                'uidParam': timestamp,
              };

              await HomeRepository().sendMessage({
                "fcmToken": getUsersData.docs[0]['fcmToken'],
                "senderName": "GUEST ($timestamp)",
                "messageSender":
                    "Selamat datang di Aplikasi Orderan Transporindo. kami ingin menanyakan sesuatu",
              });
            }
          },
        );
      }
      return resultData!;
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> openChatLogin(ChatParams params) async {
    try {
      final getData = apiClient.firestore.collection('conversations').where(
          'participants',
          isEqualTo: [params.email, sessionManager.getActiveEmail()]);
      final snapshot = await getData.get();
      Map<String, dynamic>? resultData;
      if (snapshot.docs.isNotEmpty) {
        await apiClient.firestore
            .collection('conversations')
            .doc('${params.email}||${sessionManager.getActiveEmail()}')
            .update({
          'fcmToken': sessionManager.getActiveFcmToken(),
        });
        resultData = {
          'documentId': snapshot.docs[0].id,
          'cabang': params.username,
          'fcmToken': params.fcmToken,
          'uidParam': snapshot.docs[0]['uid'],
        };
      } else {
        int timestamp = DateTime.now().millisecondsSinceEpoch;
        List<String> array = [params.email!, sessionManager.getActiveEmail()!];

        Map<String, dynamic> data = {
          "uid": timestamp,
          "participants": array,
          "user": sessionManager.getActiveName(),
          "fcmToken": sessionManager.getActiveFcmToken(),
        };
        Map<String, dynamic> chatData = {
          'message': "Kami dari Shipper Transporindo ingin menanyakan sesuatu",
          'read': false,
          'senderName': sessionManager.getActiveName(),
          'sender': sessionManager.getActiveEmail(),
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        };
        final CollectionReference parentCollection =
            apiClient.firestore.collection('conversations');

        await parentCollection
            .doc('${params.email}||${sessionManager.getActiveEmail()}')
            .set(data);
        final QuerySnapshot dataChats = await parentCollection
            .doc('${params.email}||${sessionManager.getActiveEmail()}')
            .collection('messages')
            .get();
        if (dataChats.docs.isEmpty) {
          await parentCollection
              .doc('${params.email}||${sessionManager.getActiveEmail()}')
              .collection('messages')
              .doc()
              .set(chatData);
        }
        final getDocsId = apiClient.firestore
            .collection('conversations')
            .where('participants', isEqualTo: array);
        final snapshot = await getDocsId.get();
        resultData = {
          'documentId': snapshot.docs[0].id,
          'cabang': params.username,
          'fcmToken': params.fcmToken,
          'uidParam': snapshot.docs[0]['uid'],
        };
      }
      return resultData;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> sendMessage(Map<String, dynamic> params) async {
    print(params['fcmToken']);
    var data = {
      'to': "${params['fcmToken']}",
      'priority': 'high',
      'notification': {
        'title': params["senderName"],
        'body': params["messageSender"]
      },
      'data': {
        'type': 'asdf',
        'id': 'asdf',
      }
    };
    await Dio().post(
      'https://fcm.googleapis.com/fcm/send',
      data: jsonEncode(data),
      options: Options(headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'key=AAAAqOJbQ2c:APA91bGexFK-ckEI7Hha11wAZBHnr9KNbJwfPyae3BuHIES5_Z3I8RqouctNrPlWG6a0EpvrIBRoWdVwOH-LKyNuEx54soMDLLFC6_Stv3mWCylTz3mhUOqbQTXcztmwuRF8KrhnOf87',
      }),
    );
  }
}
