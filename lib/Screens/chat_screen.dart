import 'package:chatapp/components/app_constant.dart';
import 'package:chatapp/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Widgets/chat buble.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // عشان اعمل اكسسز علي الداتابيز اللي كريتها علي ال Cloud Firestore
  CollectionReference messages =
      FirebaseFirestore.instance.collection(AppConstant.MessagesCollections);

  TextEditingController controller = TextEditingController();
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var  email =  ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      //   ال QuerySnapshot بترجع كل documents والاستريم بلدر دي عشان تعرضلي الداتا اللي بستقبلها وببعتها
      stream: messages.orderBy(AppConstant.CreatedTime, descending: true).snapshots(),

      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messageslist = [];
          // بجيب الداتا وبحطها في model
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messageslist.add(Message.fromjson(snapshot.data!.docs[i]));
          }
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppConstant.AppLogo,
                      height: 50,
                    ),
                    const Text('Chat'),
                  ],
                ),
                centerTitle: true,
                backgroundColor: AppConstant.PrimaryColor,
                // عشان اخفي سهم ال back
                automaticallyImplyLeading: false,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                        itemCount: messageslist.length,
                        itemBuilder: (context, index) =>

                         messageslist[index].id == email ? ChatBuble(
                              message: messageslist[index],
                            ) : ChatBubleForFrieng(message:  messageslist[index] )),
                  ),
                  Padding(
                    padding:  EdgeInsets.all(16),
                    child: TextField(
                        controller: controller,
                        onSubmitted: (data) {
                          messages.add({
                            //  Cloud Firestore ال key,value اللي ضفتهم علي
                            AppConstant.KeyMessage: data,
                            AppConstant.CreatedTime: DateTime.now(),
                            'id' : email
                          });
                          controller.clear();
                          // عشان يحصل اسكرول تلقائيا مع اخر رساله اتبعتت
                          _controller.animateTo(
                            _controller.position.maxScrollExtent,
                            curve: Curves.easeOut,
                            duration:  Duration(milliseconds: 500),
                          );


                        },
                        decoration: InputDecoration(
                          hintText: 'Send Message',
                          suffixIcon: const Icon(
                            Icons.send,
                            color: AppConstant.PrimaryColor,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:  BorderSide(
                                  color: AppConstant.PrimaryColor)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:  BorderSide(
                                  color: AppConstant.PrimaryColor)),
                        )),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Text('Loading....');
        }
      },
    );
  }
}
