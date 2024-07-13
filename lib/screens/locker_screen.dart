import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:csv/csv.dart';

class LockerScreen extends StatefulWidget {
  @override
  _LockerScreenState createState() => _LockerScreenState();
}

class _LockerScreenState extends State<LockerScreen> {
  String? _name;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name');
    });
  }

  Future<void> _backupPasswords() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? passwords = prefs.getStringList('passwords');

    if (passwords != null) {
      // Prompt user for PIN
      String? pin = await _showPinDialog();

      if (pin != null && pin.isNotEmpty) {
        // Encrypt the passwords
        final key = encrypt.Key.fromUtf8(pin.padRight(32));
        final iv = encrypt.IV.fromLength(16);
        final encrypter = encrypt.Encrypter(encrypt.AES(key));

        List<List<String>> csvData = [
          ['Title', 'Username', 'Password', 'Notes']
        ];
        for (var password in passwords) {
          List<String> passwordParts = password.split(',');
          csvData.add(passwordParts);
        }

        String csv = const ListToCsvConverter().convert(csvData);
        final encrypted = encrypter.encrypt(csv, iv: iv);

        // Save to file
        final directory = await getExternalStorageDirectory();
        final path = '${directory?.path}/password_backup.csv';
        final file = File(path);
        await file.writeAsString(encrypted.base64);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Backup successful: $path')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No passwords to backup')),
      );
    }
  }

  Future<String?> _showPinDialog() async {
    String? pin;
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        TextEditingController pinController = TextEditingController();
        return AlertDialog(
          title: Text('Enter PIN'),
          content: TextField(
            controller: pinController,
            keyboardType: TextInputType.number,
            obscureText: true,
            decoration: InputDecoration(hintText: 'PIN'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                pin = pinController.text;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    return pin;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Locker',
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            color: Color(0xfff6f7fb),
            child: Text(
              'Welcome, $_name!',
              style: TextStyle(
                  fontSize: 24,
                  color: Color(0xff00233c),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(20),
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              children: [
                _buildMenuItem(
                    context, 'Add New Password', Icons.add, '/add_password'),
                _buildMenuItem(context, 'View All Passwords', Icons.lock,
                    '/view_passwords'),
                _buildMenuItem(context, 'Add Secret', Icons.add_shopping_cart,
                    '/add_secret'),
                _buildMenuItem(
                    context, 'View Secrets', Icons.visibility, '/view_secrets'),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: ElevatedButton.icon(
              icon: Icon(Icons.backup),
              label: Text('Backup Passwords'),
              onPressed: _backupPasswords,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff00233c),
                foregroundColor: Colors.white,
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
      BuildContext context, String title, IconData icon, String routeName) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff00233c),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Secret Vault',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: LockerScreen(),
  ));
}
