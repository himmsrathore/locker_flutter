import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pinController = TextEditingController();

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
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
        ), // Background color of app bar
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Color(0xfff6f7fb), // Background color of body
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _pinController,
                decoration: InputDecoration(
                  labelText: 'PIN',
                  labelStyle: TextStyle(
                    color: Color(0xff00233c), // Text color of label
                    fontWeight: FontWeight.bold, // Font weight of label
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xff00233c)), // Border color when focused
                  ),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your PIN';
                  }
                  return null;
                },
                style: TextStyle(
                  color: Color(0xff00233c), // Text color of input
                  fontSize: 18, // Font size of input
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await _login();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff00233c), // background
                  foregroundColor:
                      const Color.fromARGB(255, 255, 255, 255), // foreground

                  elevation: 3, // Elevation of button
                  padding:
                      EdgeInsets.symmetric(vertical: 12), // Padding of button
                  textStyle: TextStyle(
                    fontSize: 18, // Font size of button text
                    fontWeight: FontWeight.bold, // Font weight of button text
                  ),
                ),
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedPin = prefs.getString('pin');
    String enteredPin = _pinController.text;

    if (storedPin == enteredPin) {
      Navigator.pushReplacementNamed(context, '/locker');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid PIN')),
      );
    }
  }
}
