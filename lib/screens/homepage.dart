
import 'package:flutter/material.dart';
import 'package:tugas_api_prak/model/dataclass.dart';
import 'package:tugas_api_prak/screens/profile.dart';
import 'package:tugas_api_prak/model/apiservice.dart';
import 'package:tugas_api_prak/screens/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => List_Page()),
                );
              },
              child: Text('Detail'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigasi ke halaman profile
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile_Page()),
                );
              },
              child: Text('Profile'),
            ),
            // ElevatedButton(
            //   onPressed: _logout,
            //   child: Text('Logout'),
            // ),
          ],
        ),
      ),
    );
  }
}
