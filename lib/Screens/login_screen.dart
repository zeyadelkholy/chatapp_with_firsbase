import 'package:chatapp/Widgets/custom_button.dart';
import 'package:chatapp/Widgets/custom_textfromfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/app_constant.dart';

import '../components/show_snack_bar.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  String? email;
  String? password;
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
                    SizedBox(
                      height: 50,
                    ),
                    Image.asset('assets/images/logo.png'),
                    const Text(
                      'Social Chat',
                      style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontFamily: 'Pacifico'),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Row(
                      children: const [
                        Text(
                          'LOGIN',
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomTextFromField(

                        onChanged: (data){
                          email= data;
                        },
                        hintText: 'Email'),
                    SizedBox(
                      height: 15,
                    ),
                    CustomTextFromField(
                      obscureText: true,
                        onChanged: (data){
                          password= data;
                        },
                        hintText: 'Password'),
                    SizedBox(
                      height: 30,
                    ),




                    CustomButton(
                        text: ('Login'),
                      ontap: () async {
                        if (formKey.currentState!.validate()) {
                          isLoading = true;

                          setState(() {});
                          try {
                            await loginUser();
                            ShowSnackBar(context, 'Login successfully');
                            Navigator.pushNamed(context, 'ChatScreen' , arguments: email);

                          } on FirebaseAuthException catch (ex) {
                            if (ex.code == 'user not found') {
                              ShowSnackBar(context, 'No user found for that email');

                            } else if (ex.code == 'wrong password') {
                              ShowSnackBar(context, 'wrong password for that user');
                            }
                          }

                          isLoading = false;
                          setState(() {});
                        } else {}
                      },

                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'don\'t have an account ?',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, 'RegisterScreen');
                            },
                            child: Text(
                              'REGISTER',
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





  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }

}
