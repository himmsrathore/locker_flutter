import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class ViewPasswordsScreen extends StatefulWidget {
  @override
  _ViewPasswordsScreenState createState() => _ViewPasswordsScreenState();
}

class _ViewPasswordsScreenState extends State<ViewPasswordsScreen> {
  List<Map<String, String>> _passwords = [];

  @override
  void initState() {
    super.initState();
    _loadPasswords();
  }

  Future<void> _loadPasswords() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedPasswords = prefs.getStringList('passwords');

    if (savedPasswords != null) {
      setState(() {
        _passwords = savedPasswords.map((password) {
          List<String> passwordParts = password.split(',');
          return {
            'website': passwordParts[0],
            'emailId': passwordParts[1],
            'password': passwordParts[2],
          };
        }).toList();
      });
    }
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'View All Passwords',
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
        ), // Setting app bar background color
      ),
      body: _passwords.isEmpty
          ? Center(
              child: Text(
                'No passwords saved yet',
                style: TextStyle(
                    color: Color(0xff00233c), fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              itemCount: _passwords.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 3,
                    child: ListTile(
                      leading: Icon(Icons.lock,
                          color: Color(0xff00233c)), // Icon color
                      title: GestureDetector(
                        onTap: () {
                          _launchURL(_passwords[index]['website']!);
                        },
                        child: Text(
                          _passwords[index]['website']!,
                          style: TextStyle(
                            color: Color(0xff00233c),
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      subtitle: Text(
                        _passwords[index]['emailId']!,
                        style: TextStyle(color: Color(0xff00233c)),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.visibility),
                            color: Color(0xff00233c), // Icon color
                            onPressed: () {
                              _showPasswordDialog(
                                  _passwords[index]['password']!);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            color: Colors.red, // Icon color
                            onPressed: () {
                              _deletePassword(index);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  Future<void> _showPasswordDialog(String password) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Password', style: TextStyle(color: Color(0xff00233c))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(password, style: TextStyle(color: Color(0xff00233c))),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.copy),
                    color: Color(0xff00233c), // Icon color
                    onPressed: () {
                      _copyToClipboard(password);
                      Navigator.of(context).pop(); // Close the dialog
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Password copied to clipboard')),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    color: Color(0xff00233c), // Icon color
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }

  void _deletePassword(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete',
              style: TextStyle(color: Color(0xff00233c))),
          content: Text('Are you sure you want to delete this password entry?',
              style: TextStyle(color: Color(0xff00233c))),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel', style: TextStyle(color: Color(0xff00233c))),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete', style: TextStyle(color: Colors.red)),
              onPressed: () async {
                await _performDelete(index);
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _performDelete(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> passwords = prefs.getStringList('passwords') ?? [];

    passwords.removeAt(index);

    await prefs.setStringList('passwords', passwords);

    setState(() {
      _passwords.removeAt(index);
    });
  }
}
