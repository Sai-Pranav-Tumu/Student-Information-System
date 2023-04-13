import 'package:flutter/material.dart';
import 'faculty_page.dart';
import 'images_page.dart';
import 'newsfeed_page.dart';
import 'sidebar.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      home: HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          color: Colors.blue,
        ),
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
  final tabs = [
    Container(child:NewsfeedPage()),
    Container(child:FacultyPage()),
    Container(child:ImagesPage())
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: sidebar(),
      appBar: AppBar(
        title: const Text('VNRVJIET'),
      ),
      body: tabs[selectedPage],
      bottomNavigationBar: GNav(
        gap: 6,
        backgroundColor: Colors.blueGrey,
        color: Colors.white,
        activeColor: Colors.white,
        tabBackgroundColor: Colors.blueGrey.shade800,
        padding: const EdgeInsets.all(15),
        tabs: [
          GButton(icon: Icons.home,
            text: 'News Feed',),
          // GButton(icon: Icons.feed,
          //   text: 'Feed',),
          GButton(icon: Icons.face,
            text: 'Faculty',),
          GButton(icon: Icons.image,
            text: 'Gallery',),
        ],
        selectedIndex: selectedPage,
        onTabChange: (index){
          setState(() {
            selectedPage = index;
          });
        },
      ),
    );
  }
}
