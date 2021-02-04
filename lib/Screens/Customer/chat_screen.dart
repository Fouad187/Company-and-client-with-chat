import 'package:flutter/material.dart';
import 'package:injaz/Widgets/message_list.dart';
import 'package:injaz/Widgets/send_message.dart';

class ChatScreen extends StatelessWidget {
  static String id='ChatScreenid';

  String uniqe;
  String name;
  ChatScreen({this.uniqe,this.name});
  @override
  Widget build(BuildContext context) {
    String _enterMessage="";
    _sendMessage(){
      FocusScope.of(context).unfocus();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: MessageList(uniqe: uniqe,),),
            SendMessageWidget(uniqe: uniqe,),
          ],
        ),
      ),
    );
  }
}
