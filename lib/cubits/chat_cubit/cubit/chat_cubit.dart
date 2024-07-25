import 'package:bloc/bloc.dart';
import 'package:chatapp/Constans.dart';
import 'package:chatapp/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  List<Message> messagesList = [];
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);
  void sendMessage({required String message, required String email}) {
    messages.add(
      {
        "message": message,
        'createdAt': DateTime.now(),
        'id': email,
      },
    );
  }

  void getMessages() {
    messages.orderBy('createdAt').snapshots().listen((event) {
      messagesList.clear();
      for (var doc in event.docs) {
        messagesList.add(Message.fromjson(doc));
      }
      emit(ChatSuccess(messages: messagesList));
    });
  }
}
