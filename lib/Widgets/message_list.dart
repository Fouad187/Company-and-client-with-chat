import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:injaz/Models/user_model.dart';
import 'package:injaz/Providers/user_data.dart';
import 'package:injaz/Widgets/message_bubble.dart';
import 'package:provider/provider.dart';


class MessageList extends StatelessWidget {
  
  String uniqe;
  MessageList({this.uniqe});
  @override
  Widget build(BuildContext context) {
    UserModel user=Provider.of<UserData>(context,listen: false).user;

    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Chat').where('uniqe' , isEqualTo: uniqe).orderBy('date' , descending: true).snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData)
          {
            final docs=snapshot.data.docs;
            return ListView.builder(
              reverse: true,
              itemCount: docs.length,
              itemBuilder: (context, index) {
                if(docs[index]['senderid'] == user.id)
                  {
                    return MessageBubble(isme: true, message: docs[index]['message'],); 
                  }
                else
                    {
                      return MessageBubble(isme: false, message: docs[index]['message'],);
                    }
              },
            );
          }
        else {
          return Center(child: Text('Loading...'),);
        }

      },


    );
  }
}
