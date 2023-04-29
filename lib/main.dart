
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Screens/chat_screen.dart';
import 'Screens/login_screen.dart';
import 'Screens/register_screen.dart';
import 'firebase_options.dart';

void main() async {
  // الربط بين app و firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );





  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Chat App',

      routes: {
       'LoginScreen' : (context) => LoginScreen(),
       'RegisterScreen' : (context) => RegisterScreen(),
       'ChatScreen' :  (context) =>  ChatScreen(),

      },

      theme: ThemeData(

      ),
      home:  LoginScreen(),
      initialRoute: 'LoginScreen',
    );
  }
}

