import 'package:flutter/material.dart';
class CustomText extends StatelessWidget {
  CustomText({@required this.Onclick ,@required this.hint , @required this.icon , this.passwordornot , this.initial});
  final String hint ;
  final IconData icon;
  final bool passwordornot;
  final Function Onclick;
  final initial;
  String _errormessage(String x){

    switch(x)
    {
      case 'Email' : return 'Please Enter your email';
      case 'Password' : return 'Please Enter your password';
      case 'Name' : return 'Please Enter your name';
    }
  }


  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: TextFormField(
          validator: (value){
            if(value.isEmpty)
            {
              return  _errormessage(hint);
            }
          },

          onChanged: Onclick,
          initialValue: initial,
          obscureText: passwordornot,
          cursorColor: Colors.orangeAccent,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(
              icon,
              color: Colors.deepOrangeAccent,
            ),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.deepOrangeAccent,
                )
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.white,
                )
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.white,
                )
            ),
          ),
        ),
    );
  }
}