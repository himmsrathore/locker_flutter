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
  List<Map<String, String>> _filteredPasswords = [];
  String query = '';

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

        // Initially, set filteredPasswords to passwords
        _filteredPasswords = List.from(_passwords);
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
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
          ),
          style: TextStyle(color: Colors.white),
          onChanged: _filterPasswords,
        ),
        backgroundColor: Color(0xff00233c),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: _filteredPasswords.isEmpty
            ? Center(
                child: Text(
                  'No passwords found',
                  style: TextStyle(
                    color: Color(0xff00233c),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: _filteredPasswords.length,
                itemBuilder: (context, index) {
                  final password = _filteredPasswords[index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 3,
                      child: ListTile(
                        leading: Icon(Icons.lock,
                            color: Color(0xff00233c)), // Icon color
                        title: GestureDetector(
                          onTap: () {
                            _launchURL(password['website']!);
                          },
                          child: Text(
                            password['website']!,
                            style: TextStyle(
                              color: Color(0xff00233c),
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        subtitle: Text(
                          password['emailId']!,
                          style: TextStyle(color: Color(0xff00233c)),
                        ),
                        trailing: _filteredPasswords.length == _passwords.length
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.visibility),
                                    color: Color(0xff00233c), // Icon color
                                    onPressed: () {
                                      _showPasswordDialog(
                                          password['password']!);
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
                              )
                            : IconButton(
                                icon: Icon(Icons.visibility),
                                color: Color(0xff00233c), // Icon color
                                onPressed: () {
                                  _showPasswordDialog(password['password']!);
                                },
                              ),
                      ),
                    ),
                  );
                },
              ),
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

  void _filterPasswords(String query) {
    if (query.isNotEmpty) {
      List<Map<String, String>> filteredList = _passwords
          .where((password) =>
              password['website']!.toLowerCase().contains(query.toLowerCase()))
          .toList();

      setState(() {
        _filteredPasswords = filteredList;
      });
    } else {
      setState(() {
        _filteredPasswords = List.from(_passwords);
      });
    }
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

    // Remove from main list
    passwords.removeAt(index);
    await prefs.setStringList('passwords', passwords);

    setState(() {
      _passwords.removeAt(index);

      // Update filtered list if applicable
      if (_filteredPasswords.length > index) {
        _filteredPasswords.removeAt(index);
      }
    });

    // After deletion, ensure filteredPasswords is updated correctly
    _filterPasswords(query);
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Password Vault',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: ViewPasswordsScreen(),
  ));
}
