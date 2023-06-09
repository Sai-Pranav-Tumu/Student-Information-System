import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:minor/rate1.dart';
import 'package:minor/services/auth_service.dart';
import 'AdminHomePage.dart';
import 'Attendance.dart';
import 'adminlogin.dart';
import 'courses.dart';
import 'ebooks_veiw.dart';
import 'faculty_page.dart';
import 'images_v.dart';
import 'newsfeed_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'YOUR_RECAPTCHA_SITE_KEY',
  );
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black, // background color of the splash screen
      child: Center(
        child: Image.asset(
          'assets/playstore.png', // path to your logo image file
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      // home: HomePage(),
      home: FutureBuilder(
        // Replace the StreamBuilder with FutureBuilder
        future: Future.delayed(Duration(seconds: 3)), // Wait for 3 seconds
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          } else {
            return StreamBuilder(
              stream: AuthService().firebaseAuth.authStateChanges(),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  return AdminHomePage();
                }
                return HomePage();
              },
            );
          }
        },
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blue[900],
        accentColor: Colors.redAccent,
      ),
    );
  }
}


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedPage =0;
  bool _isDarkMode = false;
  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }
  final tabs = [
    Container(child:NewsfeedPage()),
    Container(child:FacultyPage()),
    Container(child:ImagesView())
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        drawer: Drawer(
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
                onTap: () => selectedItem(context, 3),
              ),
              ListTile(
                leading: Icon(Icons.web),
                title: Text('Attendence'),
                onTap: () => selectedItem(context, 2),
                // child: Text('Go to vnrvjiet.ac.in'),
              ),
              ListTile(
                leading: Icon(Icons.rate_review),
                title: Text('Rate us'),
                onTap: () => selectedItem(context, 4),
              ),
              ListTile(
                leading: Icon(Icons.call_to_action),
                title: Text('Themes'),
                onTap: _toggleTheme,
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Admin'),
                onTap: () => selectedItem(context,0),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text('VNRVJIET'),
        ),
        body: tabs[selectedPage],
        bottomNavigationBar: GNav(
          gap: 6,
          backgroundColor: Colors.blueGrey.shade800, // update background color
          iconSize: 24,
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          duration: Duration(milliseconds: 800),
          textStyle: TextStyle(fontSize: 16, color: Colors.white),
          tabBackgroundColor: Theme.of(context).primaryColor, // use the primaryColor of the theme
          activeColor: Colors.white,
          color: Colors.white,
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.people,
              text: 'Faculty',
            ),
            GButton(
              icon: Icons.photo_album,
              text: 'Gallery',
            ),
          ],
          selectedIndex: selectedPage,
          onTabChange: (index) {
            setState(() {
              selectedPage = index;
            });
          },
        ),

      ),
      // backgroundColor: Colors.blueGrey.shade800,
    );
  }
  void selectedItem(BuildContext context, int index) {
    switch(index){
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => LoginPage()
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
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => coursesPage(),
        ));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => rate(),
        ));
        break;
      default:
        break;
    }
  }
}
