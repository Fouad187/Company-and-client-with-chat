import 'package:flutter/material.dart';
import 'package:injaz/Authentication/registeration_screen.dart';
import 'package:injaz/Providers/model_hud.dart';
import 'package:injaz/Services/auth.dart';
import 'package:injaz/Widgets/customtextfield.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static String id='LoginScreenid';
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String email,password;
  Auth auth=Auth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.deepOrangeAccent,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<Modelhud>(context).ischange,
        child: Form(
          key: _globalKey,
          child: ListView(
            children: [
              SizedBox(height: 50,),
              Image(image: AssetImage('images/repair2.png') , height: 200 , width: 200,),
              SizedBox(height: 30,),
              CustomText(
                Onclick:(value)
                {
                  email=value;
                },
                hint: 'Email',
                icon: Icons.email,
                passwordornot: false,

              ),
              SizedBox(height: 20,),
              CustomText(
                Onclick:(value)
                {
                  password=value;
                },
                hint: 'Password',
                icon: Icons.lock,
                passwordornot: true,

              ),
              SizedBox(height: 20,),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: EdgeInsets.only(left: 60 , right: 60),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.black,
                    onPressed: () async {
                      final instance =
                      Provider.of<Modelhud>(context, listen: false);
                      instance.changeisLoading(true);
                      if (_globalKey.currentState.validate()) {
                        _globalKey.currentState.save();
                          try
                          {
                            await auth.Signin(email: email , password: password , context: context);
                            instance.changeisLoading(false);
                          }
                          catch (e) {
                            instance.changeisLoading(false);
                            _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Wrong Email or Password")));
                          }
                      }
                      instance.changeisLoading(false);
                    },
                    child: Text('Login' , style: TextStyle(color: Colors.white),),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account ?', style: TextStyle(color: Colors.white , fontSize: 15),),
                    GestureDetector(
                      child: Text('Register Now', style: TextStyle(fontSize: 17),),
                      onTap: (){
                        Navigator.pushNamed(context, RegisterScreen.id);
                      },
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
