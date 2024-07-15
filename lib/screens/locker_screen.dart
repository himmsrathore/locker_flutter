import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LockerScreen extends StatefulWidget {
  @override
  _LockerScreenState createState() => _LockerScreenState();
}

class _LockerScreenState extends State<LockerScreen> {
  String? _name;
  String? _email;
  String? _contact;
  String? _pin;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name');
      _email = prefs.getString('email');
      _contact = prefs.getString('mobile');
      _pin = prefs.getString('pin');
    });
  }

  void _showUserInfoDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('User Information'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUserInfoItem('Name', _name ?? ''),
              _buildUserInfoItem('Email', _email ?? ''),
              _buildUserInfoItem('Mobile', _contact ?? ''),
              _buildUserInfoItem('PIN', _obscurePin(_pin ?? '')),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String _obscurePin(String pin) {
    // Obscure the PIN number, for example: show only the last 2 digits
    return pin.replaceRange(0, pin.length - 1, '***');
  }

  Widget _buildUserInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Locker',
          style: TextStyle(
            color: const Color.fromARGB(255, 253, 253, 253),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xff00233c),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              _showUserInfoDialog();
            },
          ),
        ],
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
                fontWeight: FontWeight.bold,
              ),
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
