import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:injaz/Models/request_model.dart';
import 'package:injaz/Models/user_model.dart';
import 'package:injaz/Providers/user_data.dart';
import 'package:provider/provider.dart';

class AllRequestScreen extends StatelessWidget {
  static String id ='AllRequestScreenid';

  @override
  Widget build(BuildContext context) {
    UserModel user=Provider.of<UserData>(context,listen: false).user;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Request History'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Requests').where('id', isEqualTo: user.id).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.hasData)
            {
              List<DocumentSnapshot> documents=snapshot.data.docs;
              List<Request> list=List<Request>();
              return ListView(
                children: documents.map((d) {
                  DateTime date;
                  date= DateTime.fromMillisecondsSinceEpoch(d['date'].millisecondsSinceEpoch);
                 return Padding(
                   padding: EdgeInsets.all(10),
                   child: Card(
                     elevation: 5,
                     color: Colors.deepOrangeAccent,
                     child: Container(
                       padding: EdgeInsets.all(10),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Expanded(child: Image(image: AssetImage(d['image']))),
                           SizedBox(width: 15 ,),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text('Name : ${d['companyname']}', style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20 , color: Colors.white),),
                               SizedBox(height: 10,),
                               Text('Time : ${d['time']}' , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20 , color: Colors.white),),
                               SizedBox(height: 10,),
                               Text('Date : ${date.year}-${date.month}-${date.day}',style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20, color: Colors.white),),
                               SizedBox(height: 15,),
                               Text('Status : ${d['status']}' ,style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20, color: Colors.white),)
                             ],
                           )
                         ],
                       ),
                     ),
                   ),
                 );
                }).toList(),
              );
            }else {
            return Text('Loading..');
          }
        } ,
      ),
    );
  }
}
