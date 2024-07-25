import 'package:chatapp/Components/Custom_Button.dart';
import 'package:chatapp/Components/Custom_text_field.dart';
import 'package:chatapp/Constans.dart';
import 'package:chatapp/cubits/register_cubit/register_cubit.dart';
import 'package:chatapp/cubits/register_cubit/register_state.dart';
import 'package:chatapp/helper/ShowSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class RegisterPage extends StatelessWidget {
  static String id = 'RegisterPage';
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          Navigator.pop(context);
          isLoading = false;
        } else if (state is RegisterFailure) {
          showSnackBar(context, state.errMsg.toString());
          isLoading = false;
        }
      },
      builder:(context,state) => ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
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
                      "Register",
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
                        BlocProvider.of<RegisterCubit>(context)
                            .registerUser(email: email!, password: password!);
                      } else {}
                    },
                    text: "Register",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        " Already have an account ? ",
                        style: TextStyle(color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Sign In",
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
}
