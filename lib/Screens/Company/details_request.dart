import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injaz/Providers/model_hud.dart';
import 'package:injaz/Screens/Customer/chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class DetailsRequest extends StatefulWidget {
  static String id='DetailsRequestID';

  final String docid;
  final String uniqe;
  final String image;
  final String companyName;
  final String companyAddress;
  final String location;
  final String zipcode;
  final String date;
  String status;
  final String name;

  DetailsRequest({ this.name,this.uniqe,this.docid,this.date, this.location , this.image , this.status , this.companyAddress , this.companyName , this.zipcode});

  @override
  _DetailsRequestState createState() => _DetailsRequestState();
}

class _DetailsRequestState extends State<DetailsRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<Modelhud>(context).ischange,
        child: ListView(
          children: [
            Container(
              height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(20) , bottomLeft: Radius.circular(20)),
                  image: DecorationImage(
                    image: AssetImage(widget.image),
                    fit: BoxFit.fill
                  )
                ),
            ),
            SizedBox(height: 10,),
            Center(child: Text('${widget.companyName} Company' , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 25),)),
            SizedBox(height: 10,),
            Padding(padding: EdgeInsets.only(left: 10 , right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Request Details' , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),),
                      widget.status=='Under Process' ? Center(child: GestureDetector(

                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(uniqe: widget.uniqe,name: widget.name,),));
                          },
                          child: Icon(Icons.message , color: Colors.deepOrangeAccent,))) : Container(),

                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Card(
                      elevation: 4,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Company Address : ${widget.companyAddress}' , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 16),),
                            SizedBox(height: 10,),
                            Text('Location on map : ${widget.location}', style: TextStyle(fontWeight: FontWeight.bold , fontSize: 16),),
                            SizedBox(height: 10,),
                            Text('Zip Code : ${widget.zipcode}', style: TextStyle(fontWeight: FontWeight.bold , fontSize: 16),),
                            SizedBox(height: 10,),
                            Text('Request Date : ${widget.date}', style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),),
                            SizedBox(height: 10,),
                            Center(child: Text('Status : ${widget.status}' , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: Container(
                      width: 300,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: Colors.deepOrangeAccent,
                        child: Text('Process Request' , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 16 ,color: Colors.white),),
                        onPressed: () async {
                          final instance =
                          Provider.of<Modelhud>(context, listen: false);
                          instance.changeisLoading(true);
                          try {
                            await FirebaseFirestore.instance.collection(
                                'Requests').doc(widget.docid).update(
                                {'status': 'Under Process'});
                            setState(() {
                              widget.status='Under Process';
                            });
                            instance.changeisLoading(false);

                          }
                          catch (e)
                          {
                            instance.changeisLoading(false);
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
