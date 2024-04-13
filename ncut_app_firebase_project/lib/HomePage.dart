import 'package:flutter/material.dart';
import 'AnnouncementPage.dart';
import 'ChatPage.dart';
import 'PersonPage.dart';
import 'main.dart';

class HomePage extends StatefulWidget {const HomePage({Key? key}) : super(key: key);@override _HomePageState createState() => _HomePageState();}

class _HomePageState extends State<HomePage> {
  String? selectedRoute;
  String? selectedDirection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                AnnouncementPage();

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnnouncementPage()),
                );
              },
              icon: Icon(Icons.announcement),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(300, 200),
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.grey[700],
              ),
              label: Text(
                'Go to Announcement Page',
                style: TextStyle(
                  fontSize: 18.0, // 文字大小
                ),
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatPage()),
                );
              },
              icon: Icon(Icons.map),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(300, 200),
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.grey[700],
              ),
              label: Text(
                'Go to Map Page',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PersonPage()),
                );
              },
              icon: Icon(Icons.person),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(300, 200),
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.grey[700],
              ),
              label: Text(
                'Go to Person Page',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }
}

