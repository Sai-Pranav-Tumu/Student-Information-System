import 'package:flutter/material.dart';
import 'package:minor/adminlogin.dart';
import 'Attendance.dart';
import 'ebooks_veiw.dart';


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
              onTap: () => selectedItem(context, 1),
            ),
            ListTile(
              leading: Icon(Icons.bookmark),
              title: Text('Courses'),
            ),
            ListTile(
              leading: Icon(Icons.web),
              title: Text('Attendence'),
              onTap: () => selectedItem(context, 2),
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
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ebooks_veiw()
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Attendance(),
        ));
        break;
      default:
        break;
    }
  }
}
