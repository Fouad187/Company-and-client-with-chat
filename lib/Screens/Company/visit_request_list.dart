import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:injaz/Screens/Company/details_request.dart';

class AllVisitRequest extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Requests').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(snapshot.hasData)
        {
          List<DocumentSnapshot> documents=snapshot.data.docs;
          return ListView(
            children: documents.map((req) {
              DateTime date;
              date=DateTime.fromMillisecondsSinceEpoch(req['date'].millisecondsSinceEpoch);
              return  Padding(
                padding: EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsRequest(
                      docid: req.documentID,
                      name: req['requestername'],
                      uniqe: req['id'],
                      image: req['image'],
                      location: req['location'],
                      companyAddress: req['address'],
                      companyName: req['companyname'],
                      date: '${date.year}-${date.month}-${date.day}',
                      status: req['status'],
                      zipcode: req['zipcode'],
                    ),));
                  },
                  child: Card(
                    elevation: 5,
                    color: Colors.deepOrangeAccent,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Image(image: AssetImage(req['requestimage']))),
                          SizedBox(width: 15 ,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Requester Name : ${req['requestername']}', style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20 , color: Colors.white),),
                              SizedBox(height: 10,),
                              Text('Time : ${req['time']}' , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20 , color: Colors.white),),
                              SizedBox(height: 10,),
                              Text('Date : ${date.year}-${date.month}-${date.day}',style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20, color: Colors.white),),
                              SizedBox(height: 15,),
                              Text('Status : ${req['status']}' ,style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20, color: Colors.white),)
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        }
        else {
          return Text('Loading.....');
        }
      } ,
    );
  }
}
