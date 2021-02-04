import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:injaz/Authentication/login_screen.dart';
import 'package:injaz/Providers/model_hud.dart';
import 'package:injaz/Screens/Company/details_request.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class SearchRequest extends StatefulWidget {
  @override
  _SearchRequestState createState() => _SearchRequestState();
}

class _SearchRequestState extends State<SearchRequest> {
  DateTime Datefrom;
  DateTime DateTo;

  bool searched=false;
  bool indate=false;
  @override
  void initState() {
    // TODO: implement initState
    Datefrom=DateTime.now();
    DateTo=DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        backgroundColor: Colors.deepOrangeAccent,
        actions: [
          GestureDetector(
              onTap: (){
                Navigator.pushReplacementNamed(context, LoginScreen.id);
              },
              child: Icon(Icons.logout , color: Colors.white, size: 30,)),
        ],
      ),
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<Modelhud>(context).ischange,
        child: Column(
          children: [
            ListTile(
              title: Text('Date From : ${Datefrom.year} , ${Datefrom.month} , ${Datefrom.day} ',),
              trailing: Icon(Icons.date_range),
              onTap: _picdate1,
            ),
            SizedBox(height: 10,),
            ListTile(
              title: Text('Date To : ${DateTo.year} , ${DateTo.month} , ${DateTo.day} ',),
              trailing: Icon(Icons.date_range),
              onTap: _picdate2,
            ),

            Container(
              width: 200,
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    searched=true;
                  });
                },
                child: Text('Search' , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white),),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Colors.deepOrangeAccent,
              ),
            ),
            Divider(height: 20, color: Colors.grey,),
            SizedBox(height: 10,),
            searched ? Expanded(
                child: Container(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('Requests').where('date', isGreaterThanOrEqualTo: Datefrom , isLessThanOrEqualTo: DateTo).snapshots(),
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
                    )



                ),
            ) : Container(),
          ],
        ),
      ),

    );

  }
  _picdate1() async
  {
    DateTime dateTime=await showDatePicker(
      context: context,
      initialDate: Datefrom,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year+1),
    );
    if(dateTime !=null)
    {
      setState(() {
        Datefrom=dateTime;
      });
    }

  }
  _picdate2() async
  {
    DateTime dateTime=await showDatePicker(
      context: context,
      initialDate: Datefrom,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year+1),
    );
    if(dateTime !=null)
    {
      setState(() {
        DateTo=dateTime;
      });
    }

  }
}
