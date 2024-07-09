import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Passwords are like underwear: you don’t let people see it, \n you should change it very often, and you shouldn t share it with \nstrangers- Chris Pirillo',
          style: TextStyle(
            color: Colors.white, // Text color of app bar title
            fontSize: 12, // Font size of app bar title
            fontWeight: FontWeight.bold, // Font weight of app bar title
          ),
        ),
        backgroundColor: Color(0xff00233c), // Background color of app bar
        iconTheme: IconThemeData(
          color: Colors.white, // Color of the back icon
        ),
      ),
      body: Container(
        color: Color(0xfff6f7fb), // Background color of body
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 150, // Set the width of the logo
                  height: 150, // Set the height of the logo
                ),
                SizedBox(height: 20), // Space between the logo and welcome text
                Text(
                  'Welcome to Locker',
                  style: TextStyle(
                    color: Color(0xff00233c), // Text color
                    fontSize: 26, // Font size
                    fontWeight: FontWeight.bold, // Font weight
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40), // Space between the text and buttons
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color(0xff00233c), // Button background color
                    elevation: 3, // Elevation of the button
                    padding: EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15), // Padding of the button
                    textStyle: TextStyle(
                      fontSize: 18, // Font size of button text
                      fontWeight: FontWeight.bold, // Font weight of button text
                    ),
                  ),
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: const Color.fromARGB(
                          255, 253, 253, 253), // Text color of app bar title
                      fontSize: 20, // Font size of app bar title
                      fontWeight:
                          FontWeight.bold, // Font weight of app bar title
                    ),
                  ),
                ),
                SizedBox(height: 20), // Space between the buttons
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color(0xff00233c), // Button background color
                    elevation: 3, // Elevation of the button
                    padding: EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15), // Padding of the button
                    textStyle: TextStyle(
                      fontSize: 18, // Font size of button text
                      fontWeight: FontWeight.bold, // Font weight of button text
                    ),
                  ),
                  child: Text(
                    'Login Now',
                    style: TextStyle(
                      color: const Color.fromARGB(
                          255, 253, 253, 253), // Text color of app bar title
                      fontSize: 20, // Font size of app bar title
                      fontWeight:
                          FontWeight.bold, // Font weight of app bar title
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
