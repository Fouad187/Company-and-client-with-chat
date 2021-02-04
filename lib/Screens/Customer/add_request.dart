import 'package:flutter/material.dart';
import 'package:injaz/Authentication/login_screen.dart';
import 'package:injaz/Models/user_model.dart';
import 'package:injaz/Providers/model_hud.dart';
import 'package:injaz/Providers/user_data.dart';
import 'package:injaz/Screens/Customer/chat_screen.dart';
import 'package:injaz/Services/requests.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class AddRequestScreen extends StatefulWidget {
  static String id='AddRequestScreenid';

  @override
  _AddRequestScreenState createState() => _AddRequestScreenState();
}

class _AddRequestScreenState extends State<AddRequestScreen> {
  DateTime PicDate;
  TimeOfDay timeOfDay;
  RequestServices req=RequestServices();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    PicDate=DateTime.now();
    timeOfDay=TimeOfDay.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserModel user=Provider.of<UserData>(context,listen: false).user;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Add Visit Request'),
        backgroundColor: Colors.deepOrangeAccent,
        actions: [
          GestureDetector(
              onTap: (){
                Navigator.pushReplacementNamed(context, LoginScreen.id);
              },
              child: Icon(Icons.logout , color: Colors.white, size: 30,)),
          GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(name: 'Injaz Tech', uniqe: user.id,),));
              },
              child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Icon(Icons.message,color: Colors.white, size: 30,))),
        ],
      ),
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<Modelhud>(context).ischange,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              title: Text('Date : ${PicDate.year} , ${PicDate.month} , ${PicDate.day} ',),
              trailing: Icon(Icons.date_range),
              onTap: _picdate,
            ),
            SizedBox(height: 20,),
            ListTile(
              title: Text('Time : ${timeOfDay.hour} : ${timeOfDay.minute} '),
              trailing: Icon(Icons.timer),
              onTap: _pictime,
            ),

            SizedBox(height: 30,),
            Container(
              width: 200,
              child: FlatButton(
                  onPressed: () async {
                    final instance =
                    Provider.of<Modelhud>(context, listen: false);
                    instance.changeisLoading(true);
                    String date='${PicDate.year}-${PicDate.month}-${PicDate.day} ';
                    String time='${timeOfDay.hour} : ${timeOfDay.minute} ';
                    try
                    {
                      await req.addVisitRequest(time: time , date: PicDate , context: context);
                      instance.changeisLoading(false);
                      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Request Was Added')));

                    }
                    catch (e) {
                      instance.changeisLoading(false);
                      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Somthing Wrong try again")));
                    }

                    },
                  child: Text('Add' , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white),),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Colors.deepOrangeAccent,
              ),
            ),
          ],
        ),
      ),
    );

  }
  _picdate() async
  {
  DateTime dateTime=await showDatePicker(
        context: context,
        initialDate: PicDate,
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(DateTime.now().year+1),
    );
  if(dateTime !=null)
    {
      setState(() {
        PicDate=dateTime;
      });
    }

  }
  _pictime() async
  {
    TimeOfDay time=await showTimePicker(context: context,
        initialTime: timeOfDay);

    if(time !=null)
    {
      setState(() {
        timeOfDay=time;
      });
    }
  }
}