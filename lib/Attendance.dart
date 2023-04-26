import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Attendance extends StatefulWidget {
  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
   String attendancePercent ='';
   TextEditingController _controllerA = TextEditingController();
   TextEditingController _controllerB = TextEditingController();

  Future<void> _getAttendance() async {
    // try {
      String a = _controllerA.text;
      String b = _controllerB.text;

      // Make HTTP request to Flask API
      var response = await http.post(
        Uri.parse('http://localhost:5000/add'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'a': a, 'b': b}),
      );

      // Parse response and update result text
      var data = jsonDecode(response.body);
      setState(() {
        attendancePercent = data['result'];
      });

    // } catch (e) {
    //   print('Error getting attendance: $e');
    //   attendancePercent = 'Error getting attendance';
    // }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: Text('Get Attendance'),
              onPressed: _getAttendance,
            ),
            SizedBox(height: 16),
            Text(attendancePercent),
          ],
        ),
      ),
    );
  }
}
