import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tasorderan/params/home_params.dart';
import 'package:tasorderan/repo/home_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final homeRepository = HomeRepository();
  ChatBloc() : super(ChatInitial()) {
    on<StartChatEventLogin>((event, emit) async {
      try {
        print("baca chat event login dong");
        emit(ChatLoading());
        final params = ChatParams(
          event.email,
          event.username,
          event.fcmToken,
        );
        final response = await homeRepository.openChatLogin(params);
        emit(ChatSuccess(response));
      } catch (e) {
        emit(ChatFailed(e.toString()));
      }
    });
    on<StartChatEventNotLogin>((event, emit) async {
      try {
        emit(ChatLoading());
        print("baca sini");
        final params = ChatParams(
          event.email,
          event.username,
          event.fcmToken,
        );
        final response = await homeRepository.openChatNotLogin(params);
        print("berhasil hore");
        emit(ChatSuccess(response));
      } catch (e) {
        emit(ChatFailed(e.toString()));
      }
    });
  }
}
