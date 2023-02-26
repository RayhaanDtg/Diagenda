import 'package:diagenda/pages/calendar_view.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CalendarViewPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.greenAccent],
                begin: Alignment.bottomLeft,
                end: Alignment.centerRight),
            boxShadow: [
              BoxShadow(
                  offset: Offset(5, 5),
                  blurRadius: 10,
                  color: Colors.blueAccent)
            ]),
        child: Center(
          child: CircleAvatar(
            radius: 75,
            child: Image.asset('assets/logo.png'),
          ),
        ),
      ),
    );
  }
}
