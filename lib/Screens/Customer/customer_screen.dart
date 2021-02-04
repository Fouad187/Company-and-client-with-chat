import 'package:flutter/material.dart';
import 'file:///D:/FCIS_2020/Rab3aaa/Gp/injaz/lib/Screens/Customer/all_requests.dart';
import 'file:///D:/FCIS_2020/Rab3aaa/Gp/injaz/lib/Screens/Customer/chat_screen.dart';

import 'add_request.dart';

class CustomerScreen extends StatefulWidget {
  static String id='CustomerScreenid';

  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  int selectedIndex=0;

  final tabs=[
    AddRequestScreen(),
    AllRequestScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepOrangeAccent,
        currentIndex: selectedIndex,
        onTap: (index){
          setState(() {
            selectedIndex=index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle),
              label: 'New Request',

          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Previous Requests'
          ),
        ],
      ),
      body: tabs[selectedIndex],
    );
  }
}
