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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/images/logo.png', // Replace with your app logo
                height: 100,
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Color(0xff00233c), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About Us',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff00233c),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Welcome to Locker App! ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff00233c),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Locker App is designed to keep your sensitive information secure and easily accessible. Whether it\'s your login credentials, secret notes, payment cards, or online identities, we provide a safe and convenient place to store them.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff00233c),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Our Mission',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff00233c),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Our mission is to protect your digital life by providing state-of-the-art security solutions. We believe in privacy, simplicity, and accessibility. Our app is user-friendly and ensures your data is encrypted and stored only on your device.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff00233c),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: 10),
                  Text(
                    '"The best way to predict the future is to create it." - Peter Drucker',
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Color(0xff00233c),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          '© 2024 by White Hawk. Version(1.0.1)',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: Color(0xff00233c),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          ' Made in India with',
                          style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            color: Color(0xff00233c),
                          ),
                        ),
                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 24.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
