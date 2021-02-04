import 'package:flutter/material.dart';
import 'package:injaz/Screens/Company/search_request.dart';
import 'package:injaz/Screens/Company/visit_request_list.dart';
import 'package:injaz/Screens/Customer/chat_screen.dart';

class CompanyScreen extends StatefulWidget {
  static String id='CompanyScreenid';

  @override
  _CompanyScreenState createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  int selectedIndex=0;

  final tabs=[
    SearchRequest(),
    AllVisitRequest(),
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
            icon: Icon(Icons.search),
            label: 'Searching',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'All Visit Request',
          ),

        ],
      ),
      body: tabs[selectedIndex],
    );
  }
}
