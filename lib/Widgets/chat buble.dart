import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/app_constant.dart';
import '../models/message_model.dart';

class ChatBuble extends StatelessWidget {
   ChatBuble({
    Key? key, required this.message,
  }) : super(key: key);
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Color(0xff006D84),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                  topLeft: Radius.circular(32),
                )
            ),
            child: Text( message.message,
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }
}


class ChatBubleForFrieng extends StatelessWidget {
  ChatBubleForFrieng({
    Key? key, required this.message,
  }) : super(key: key);
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: AppConstant.PrimaryColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(32),
                  topRight: Radius.circular(32),
                  topLeft: Radius.circular(32),
                )
            ),
            child: Text( message.message,
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }
}