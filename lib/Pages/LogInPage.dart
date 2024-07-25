import 'package:chatapp/Components/Custom_Button.dart';
import 'package:chatapp/Components/Custom_text_field.dart';
import 'package:chatapp/Pages/ChatPage.dart';
import 'package:chatapp/Pages/Register_Page.dart';
import 'package:chatapp/cubits/chat_cubit/cubit/chat_cubit.dart';
import 'package:chatapp/cubits/logIn_cubit/log_in_cubit.dart';
import 'package:chatapp/cubits/logIn_cubit/log_in_state.dart';
import 'package:chatapp/helper/ShowSnackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class LogInPage extends StatelessWidget {
  static String id = 'LogInPage';
  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;
  String? email;

  String? password;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogInCubit, LogInState>(
      listener: (context, state) {
        if (state is LogInLoading) {
          isLoading = true;
        } else if (state is LogInSuccess) {
          BlocProvider.of<ChatCubit>(context).getMessages();
          Navigator.pushNamed(context, ChatPage.id, arguments: email!);
          isLoading = false;
        } else if (state is LogInFailure) {
          showSnackBar(context, state.errMsg.toString());
          isLoading = false;
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: const Color(0xff2B475B),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Image.asset(
                    "assets/images/scholar.png",
                    height: 100,
                  ),
                  const Center(
                    child: Text(
                      "Scholar Chat",
                      style: TextStyle(
                          fontSize: 32,
                          fontFamily: 'Pacifico',
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    hint: "Email",
                    onChanged: (data) {
                      email = data;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomPasswordTextField(
                    hint: "Password",
                    onChanged: (data) {
                      password = data;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    ontap: () async {
                      if (formKey.currentState!.validate()) {
                        await BlocProvider.of<LogInCubit>(context)
                            .logInUser(email: email!, password: password!);
                      } else {}
                    },
                    text: "Sign In",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Dont\t have an account ? ",
                        style: TextStyle(color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RegisterPage.id);
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> logInUser() async {
    // ignore: unused_local_variable
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
