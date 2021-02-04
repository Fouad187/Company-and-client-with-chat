import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injaz/Models/request_model.dart';
import 'package:injaz/Models/user_model.dart';
import 'package:injaz/Providers/user_data.dart';
import 'package:provider/provider.dart';

class RequestServices
{
  final CollectionReference _userCollection=FirebaseFirestore.instance.collection('Requests');

  addVisitRequest({DateTime date , String time , context}) async
  {
    UserModel user=Provider.of<UserData>(context,listen: false).user;
    Request request=Request(
      id: user.id,
      date: date,
      time: time,
      image: 'images/logo.jpg',
      companyname: 'Injaz Tech',
      status: 'Established',
      address: '16 New Cairo',
      zipCode: '27156',
      location: 'Naser City',
      requesterName: user.name,
      requestImage: 'images/request.png'
    );
    return await _userCollection.doc().set(request.toJson());
  }




}