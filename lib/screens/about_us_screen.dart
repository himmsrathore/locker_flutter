import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us',
          style: TextStyle(
            color: const Color.fromARGB(
                255, 253, 253, 253), // Text color of app bar title
            fontSize: 20, // Font size of app bar title
            fontWeight: FontWeight.bold, // Font weight of app bar title
          ),
        ),
        backgroundColor: Color(0xff00233c),
        iconTheme: IconThemeData(
          color: Colors.white, // Color of the back icon
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(
              child: Text(
                '“The quieter you become, the more you can hear.”\n- Ram Dass',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Color(0xff00233c),
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              'About Password Keeper',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xff00233c),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Password Keeper is your secure vault for storing and managing your passwords. '
              'Designed with simplicity and security in mind, it ensures that all your sensitive information '
              'is safely encrypted and easily accessible only to you. Say goodbye to forgotten passwords '
              'and enjoy peace of mind with our robust security features.',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff00233c),
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: Text(
                '© 2024 by White Hawk. Made in India with heart.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Color(0xff00233c),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
