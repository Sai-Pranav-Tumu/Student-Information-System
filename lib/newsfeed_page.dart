import 'package:flutter/material.dart';

class NewsfeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Newsfeed'),
      ),
      body: ListView(
        children: List.generate(5, (index) {
          return ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Text('News $index'),
            subtitle: Text('This is some news.'),
          );
        }),
      ),
    );
  }
}
