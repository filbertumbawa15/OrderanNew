part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

final class ChatInitial extends ChatState {}

final class ChatLoading extends ChatState {}

final class ChatSuccess extends ChatState {
  final Map<String, dynamic> result;

  const ChatSuccess(this.result);
}

final class ChatFailed extends ChatState {
  final String? message;

  const ChatFailed(this.message);
}
