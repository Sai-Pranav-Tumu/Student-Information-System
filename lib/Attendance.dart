import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Attendance extends StatefulWidget {
  const Attendance({Key? key}) : super(key: key);

  @override
  _facultypageState createState() => _facultypageState();
}

class _facultypageState extends State<Attendance> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _webViewController = Completer<WebViewController>();
  String _attendancePercentage = "updating";
  Future<void> _getAttendance() async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    // Navigate to the login page
    await _webViewController.future.then((controller) {
      controller.loadUrl('https://automation.vnrvjiet.ac.in/EduPrime3/VNRVJIET');
    });
    // Wait for the login page to load and enter the credentials and click the login button
    await Future.delayed(Duration(seconds: 2));
    await _webViewController.future.then((controller) async {
      await controller.runJavascript(
        "document.getElementsByName('UserName')[0].value = '$username';"
            "document.getElementsByName('xPassword')[0].value = '$password';"
            "document.querySelector(\"button[type='submit']\").click();",
      );
    });
    // Wait for the dashboard page to load and click the attendance button
    await Future.delayed(Duration(seconds: 2));
    await _webViewController.future.then((controller) async {
      await controller.runJavascript(
        "document.querySelector('#attp').click();",
      );
    });
    // Wait for the attendance page to load and get the attendance percentage
    await Future.delayed(Duration(seconds: 2));
    await _webViewController.future.then((controller) async {
      final attendancePercentage = await controller.runJavascriptReturningResult(
        "document.querySelector('h4.font-medium.m-b-0').innerText;",
      );
      setState(() {
        _attendancePercentage = attendancePercentage;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await _getAttendance();
                },
                child: const Text('Get Attendance'),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  _attendancePercentage,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Container(
                width: 0.1,
                height: 0.1,
                child: WebView(
                  initialUrl: 'https://automation.vnrvjiet.ac.in/EduPrime3/VNRVJIET',
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (controller) {
                    _webViewController.complete(controller);
                  },
                  javascriptChannels: <JavascriptChannel>[
                    JavascriptChannel(
                      name: 'flutter_inappwebview',
                      onMessageReceived: (JavascriptMessage message) {
                        print(message.message);
                      },
                    )
                  ].toSet(),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
