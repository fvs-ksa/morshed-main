import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'chat_support_state.dart';

class ChatWithSupportCubit extends Cubit<ChatWithSupportState> {
  ChatWithSupportCubit() : super(InitialChatWithSupportState());

  static ChatWithSupportCubit get(context) => BlocProvider.of(context);
  List<String> messages = [];

  sendTextMessage(String message) {
    messages.add(message);
    emit(SendTextMessageState());
  }

  void arabicTextField({required TextEditingController controller}) {
    if (controller.selection ==
        TextSelection.fromPosition(
            TextPosition(offset: controller.text.length - 1))) {
      // setState(() {
      controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length));
      // });
      emit(ArabicTextFieldAuthState());
    }
  }
}
