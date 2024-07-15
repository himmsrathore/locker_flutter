import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Add this import
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart'; // Replace with the actual file name of your main screen

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(seconds: 5), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => HomeScreen()), // Replace with your main screen
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add your splash screen logo or any other widget here
            Image.asset(
              'assets/images/logo.png',
              width: 100,
              height: 100,
            ),
            SizedBox(height: 20),
            Text(
              'Secret Vault',
              style: TextStyle(
                color: Color(0xff00233c),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
