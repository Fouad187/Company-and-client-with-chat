import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:injaz/Authentication/login_screen.dart';
import 'package:injaz/Authentication/registeration_screen.dart';
import 'package:injaz/Providers/model_hud.dart';
import 'package:injaz/Providers/user_data.dart';
import 'package:injaz/Screens/Company/details_request.dart';
import 'package:injaz/Screens/Customer/chat_screen.dart';
import 'file:///D:/FCIS_2020/Rab3aaa/Gp/injaz/lib/Screens/Customer/add_request.dart';
import 'file:///D:/FCIS_2020/Rab3aaa/Gp/injaz/lib/Screens/Customer/all_requests.dart';
import 'file:///D:/FCIS_2020/Rab3aaa/Gp/injaz/lib/Screens/Company/company_screen.dart';
import 'file:///D:/FCIS_2020/Rab3aaa/Gp/injaz/lib/Screens/Customer/customer_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Modelhud>(create: (context) => Modelhud(),),
        ChangeNotifierProvider<UserData>(create: (context) => UserData(),),


      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: LoginScreen.id,
        routes: {
          LoginScreen.id:(context)=>LoginScreen(),
          RegisterScreen.id:(context)=>RegisterScreen(),
          CustomerScreen.id:(context)=>CustomerScreen(),
          CompanyScreen.id:(context)=>CompanyScreen(),
          AddRequestScreen.id:(context)=>AddRequestScreen(),
          AllRequestScreen.id:(context)=>AllRequestScreen(),
          DetailsRequest.id:(context)=>DetailsRequest(),
          ChatScreen.id:(context)=>ChatScreen(),
        },
      ),
    );
  }
}
