import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../Widgets/custom_button.dart';
import '../Widgets/custom_textfromfield.dart';
import '../components/app_constant.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(

        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: AppConstant.PrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Image.asset(AppConstant.AppLogo),
                    const Text(
                      'Social Chat',
                      style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontFamily: 'Pacifico'),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Row(
                      children: [
                        const Text(
                          'RESGISTER',
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextFromField(
                        // حطيت data دي عشان بستقبل string
                        onChanged: (data) {
                          email = data;
                        },
                        hintText: 'Email'),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextFromField(
                        // حطيت data دي عشان بستقبل string
                        onChanged: (data) {
                          password = data;
                        },
                        hintText: 'Password'),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomButton(
                      text: ('Resgister'),
                      ontap: () async {
                        if (formKey.currentState!.validate()) {
                          isLoading = true;

                          setState(() {});
                          try {
                            await registerUser();
                            ShowSnackBar(context, 'email created successfully');
                            Navigator.pushNamed(context, 'ChatScreen');

                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak password') {
                              ShowSnackBar(
                                  context, 'The password is very weak');
                            } else if (e.code == 'The email is already used') {
                              ShowSnackBar(
                                  context, 'The email is already exists');
                            }
                          }

                          isLoading = false;
                          setState(() {});
                        } else {}
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'don\'t have an account ?',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(color: Color(0XFFC7EDE6)),
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void ShowSnackBar(BuildContext context, String massage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: EdgeInsets.all(15),
        content: Text(massage),
      ),
    );
  }

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
