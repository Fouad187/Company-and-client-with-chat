import 'package:flutter/material.dart';
import 'package:injaz/Providers/model_hud.dart';
import 'file:///D:/FCIS_2020/Rab3aaa/Gp/injaz/lib/Screens/Company/company_screen.dart';
import 'file:///D:/FCIS_2020/Rab3aaa/Gp/injaz/lib/Screens/Customer/customer_screen.dart';
import 'package:injaz/Services/auth.dart';
import 'package:injaz/Widgets/customtextfield.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
class RegisterScreen extends StatefulWidget {
  static String id='RegisterScreenid';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String name,email,password,typee='Customer';

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Auth auth=Auth();

  List<String> type=[
    'Customer',
    'Company',
  ];

  String selected='Customer';

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
              SizedBox(height: 10,),
              Image(image: AssetImage('images/repair2.png') , height: 200 , width: 200,),
              SizedBox(height: 30,),
              CustomText(
                Onclick:(value)
                {
                  name=value;
                },
                hint: 'Name',
                icon: Icons.account_box,
                passwordornot: false,

              ),
              SizedBox(height: 20,),
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
              SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    Text('Type : ' , style: TextStyle(fontSize: 17 , fontWeight: FontWeight.bold , color: Colors.white),),
                    SizedBox(width: 10,),
                    DropdownButton(dropdownColor: Colors.deepOrangeAccent,items: getitem(type), value:selected, onChanged: (value){
                      setState(() {
                        selected=value;
                        typee=value;
                      });
                    }
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
               Padding(
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
                      if (_globalKey.currentState.validate())
                      {
                        _globalKey.currentState.save();
                          try {
                            await auth.CreateAccount(name: name,
                                type: typee,
                                email: email,
                                password: password,
                              context: context,
                            );
                            if(typee=='Customer')
                              {
                                Navigator.pushNamedAndRemoveUntil(context, CustomerScreen.id, (route) => false);
                              }
                            else {
                              Navigator.pushNamedAndRemoveUntil(context, CompanyScreen.id, (route) => false);

                            }
                            instance.changeisLoading(false);
                          }
                          catch (e) {
                            instance.changeisLoading(false);
                            _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Email Must be Uniqe")));
                          }
                      }
                      instance.changeisLoading(false);
                    },
                    child: Text('Register' , style: TextStyle(color: Colors.white),),
                ),
              ),
              SizedBox(height: 20,),
               Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already Have an account? ', style: TextStyle(color: Colors.white , fontSize: 15),),
                    GestureDetector(
                      child: Text('Login Now', style: TextStyle(fontSize: 17),),
                      onTap: (){
                        Navigator.pop(context);
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

List<DropdownMenuItem> getitem(List<String> list)
{
  List<DropdownMenuItem> dropdownmenuitem=[];
  for(int i=0 ; i<list.length; i++)
  {
    String type=list[i];
    var newitem=DropdownMenuItem(
      child: Text(type , style: TextStyle(color: Colors.white),) ,
      value: type,
    );
    dropdownmenuitem.add(newitem);
  }
  return dropdownmenuitem;
}