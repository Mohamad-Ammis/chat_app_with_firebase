
import 'package:chatapp/Components/ChatBuble.dart';
import 'package:chatapp/Constans.dart';
import 'package:chatapp/cubits/chat_cubit/cubit/chat_cubit.dart';
import 'package:chatapp/models/message.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ChatPage extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  final ScrollController _controllerList = ScrollController();
  static String id = 'ChatPage';

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                kLogo,
                height: 50,
              ),
              const Text("Chat"),
            ],
          ),
          backgroundColor: kPrimaryColor,
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                    List<Message> messagesList =
                      BlocProvider.of<ChatCubit>(context).messagesList;
                  return ListView.builder(
                      controller: _controllerList,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        return messagesList[index].id == email
                            ? ChatBuble(
                                msg: messagesList[index],
                              )
                            : ChatBubleFromFriend(msg: messagesList[index]);
                      });
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: controller,
                  onSubmitted: (data) {
                    BlocProvider.of<ChatCubit>(context).sendMessage(message: data,email: email);
                    controller.clear();
                    _controllerList.animateTo(
                      _controllerList.position.maxScrollExtent,
                      duration: Duration(microseconds:500 ),
                      curve: Curves.fastOutSlowIn,
                    );
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 12),
                    hintText: "Send Message",
                    suffixIcon: const Icon(
                      Icons.send,
                      color: kPrimaryColor,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: kPrimaryColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ))
          ],
        ));
  }
}
