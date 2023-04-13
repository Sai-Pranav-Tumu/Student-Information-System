import 'package:flutter/material.dart';
import 'package:minor/adminlogin.dart';

class sidebar extends StatefulWidget {
  const sidebar({Key? key}) : super(key: key);

  @override
  State<sidebar> createState() => _sidebarState();
}

class _sidebarState extends State<sidebar> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.book),
              title: Text('Ebooks'),
            ),
            ListTile(
              leading: Icon(Icons.bookmark),
              title: Text('Courses'),
            ),
            ListTile(
              leading: Icon(Icons.web),
              title: Text('Website'),
            ),
            ListTile(
              leading: Icon(Icons.rate_review),
              title: Text('Rate us'),
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Share app'),
            ),
            ListTile(
              leading: Icon(Icons.call_to_action),
              title: Text('Themes'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Admin'),
              onTap: () => selectedItem(context,0),
            ),
          ],
        ),
      ),
    );
  }

  void selectedItem(BuildContext context, int index) {
    switch(index){
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => adminlogin()
        ));
    }
  }
}
