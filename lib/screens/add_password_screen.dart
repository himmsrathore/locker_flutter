import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPasswordScreen extends StatefulWidget {
  @override
  _AddPasswordScreenState createState() => _AddPasswordScreenState();
}

class _AddPasswordScreenState extends State<AddPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  String _website = '';
  String _emailId = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Password',
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
        ), // App bar background color
      ),
      body: Container(
        color: Color(0xfff6f7fb), // Body background color
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Website / URL',
                  labelStyle: TextStyle(
                    color: Color(0xff00233c),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the website';
                  }
                  return null;
                },
                onSaved: (value) {
                  _website = value!;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email ID / Username',
                  labelStyle: TextStyle(
                    color: Color(0xff00233c),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email ID';
                  }
                  return null;
                },
                onSaved: (value) {
                  _emailId = value!;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Color(0xff00233c),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                obscureText:
                    false, // Set to false to show the password in plain text
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the password';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    await _savePassword();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Password saved')),
                    );
                    Navigator.pop(context); // Go back to the previous screen
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color(0xff00233c), // Button background color
                  ),
                  foregroundColor: MaterialStateProperty.all<Color>(
                    Colors.white, // Button text color
                  ),
                ),
                child: Text('Save Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _savePassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Format the password entry
    String passwordEntry = '$_website,$_emailId,$_password';

    // Retrieve existing passwords or initialize an empty list
    List<String> passwords = prefs.getStringList('passwords') ?? [];

    // Add the new password entry to the list
    passwords.add(passwordEntry);

    // Save the updated list back to SharedPreferences
    await prefs.setStringList('passwords', passwords);
  }
}
