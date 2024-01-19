part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class StartChatEventLogin extends ChatEvent {
  String? email;
  String? username;
  String? fcmToken;

  StartChatEventLogin({this.email, this.username, this.fcmToken});
}

class StartChatEventNotLogin extends ChatEvent {
  String? email;
  String? username;
  String? fcmToken;

  StartChatEventNotLogin({this.email, this.username, this.fcmToken});
}

class ChatInsert extends ChatEvent {}
