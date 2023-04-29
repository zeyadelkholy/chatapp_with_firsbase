 import 'package:chatapp/components/app_constant.dart';

class Message {

  final String message;
  final String id;
  Message(this.message, this.id);

  factory Message.fromjson(jsonrespond)
  {
    return Message(jsonrespond[AppConstant.KeyMessage] , jsonrespond['id']);

  }
}