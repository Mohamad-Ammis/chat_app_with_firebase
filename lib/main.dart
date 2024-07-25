import 'package:chatapp/Pages/ChatPage.dart';
import 'package:chatapp/Pages/LogInPage.dart';
import 'package:chatapp/Pages/Register_Page.dart';
import 'package:chatapp/cubits/chat_cubit/cubit/chat_cubit.dart';
import 'package:chatapp/cubits/logIn_cubit/log_in_cubit.dart';
import 'package:chatapp/cubits/register_cubit/register_cubit.dart';
import 'package:chatapp/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LogInCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider(
          create: (context) => ChatCubit(),
        ),
      ],
      child: MaterialApp(
        routes: {
          LogInPage.id: (context) => LogInPage(),
          ChatPage.id: (context) => ChatPage(),
          RegisterPage.id: (context) => RegisterPage(),
        },
        initialRoute: LogInPage.id,
      ),
    );
  }
}
