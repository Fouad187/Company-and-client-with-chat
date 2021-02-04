
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:injaz/Models/user_model.dart';
import 'package:injaz/Providers/user_data.dart';
import 'file:///D:/FCIS_2020/Rab3aaa/Gp/injaz/lib/Screens/Company/company_screen.dart';
import 'file:///D:/FCIS_2020/Rab3aaa/Gp/injaz/lib/Screens/Customer/customer_screen.dart';
import 'package:provider/provider.dart';
class Auth
{

  FirebaseAuth _auth=FirebaseAuth.instance;
  final CollectionReference _userCollection=FirebaseFirestore.instance.collection('Users');


  void Signin({String email , String password , context}) async
 {
     await _auth.signInWithEmailAndPassword(email: email, password: password).then((value) {
       _userCollection.doc(value.user.uid).get().then((value2) {
         var type = (value2)['type'];
         UserModel userModel=UserModel(
           email: (value2)['email'],
           id: value.user.uid,
           name: (value2)['name'],
           type: (value2)['type'],
         );
         Provider.of<UserData>(context , listen: false).setUser(userModel);
         if(type=='Customer')
           {
             Navigator.pushNamedAndRemoveUntil(context, CustomerScreen.id, (route) => false);
           }
         else {
           Navigator.pushNamedAndRemoveUntil(context, CompanyScreen.id, (route) => false);
         }

       });
     });
 }
  void CreateAccount({String name,String email , String password,String type,context}) async {


      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((user) async {
        UserModel usermodel=UserModel(
          id: user.user.uid,
          name: name,
          email: email,
          type: type,
        );

        await Adduserdata(usermodel);
        Provider.of<UserData>(context , listen: false).setUser(usermodel);

      });

  }

  Future<void> Adduserdata(UserModel userModel) async {
    return await _userCollection.doc(userModel.id).set(userModel.toJson());
  }



}