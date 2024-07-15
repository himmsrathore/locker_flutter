import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart'; // Add this import

class ViewSecretsScreen extends StatefulWidget {
  @override
  _ViewSecretsScreenState createState() => _ViewSecretsScreenState();
}

class _ViewSecretsScreenState extends State<ViewSecretsScreen> {
  List<Map<String, String>> _secrets = [];
  List<Map<String, String>> _filteredSecrets = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadSecrets();
  }

  Future<void> _loadSecrets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedSecrets = prefs.getStringList('secrets');

    if (savedSecrets != null) {
      setState(() {
        _secrets = savedSecrets.map((secret) {
          List<String> secretParts = secret.split(',');
          return {
            'title': secretParts[0],
            'description': secretParts[1],
            'privacyLevel': secretParts[2],
            'timestamp': secretParts[3],
          };
        }).toList();
        _filteredSecrets = List.from(_secrets); // Initialize filtered list
      });
    }
  }

  void _filterSecrets(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredSecrets =
            List.from(_secrets); // Reset to full list if query is empty
      } else {
        _filteredSecrets = _secrets.where((secret) {
          return secret['title']!.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  Future<void> _deleteSecret(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> secrets = prefs.getStringList('secrets') ?? [];

    // Remove from main list
    secrets.removeAt(index);
    await prefs.setStringList('secrets', secrets);

    setState(() {
      _secrets.removeAt(index);
      // Update filtered list
      _filteredSecrets.removeAt(index);
    });
  }

  Future<void> _editSecret(int index) async {
    TextEditingController titleController =
        TextEditingController(text: _filteredSecrets[index]['title']);
    TextEditingController descriptionController =
        TextEditingController(text: _filteredSecrets[index]['description']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Secret'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                List<String> secrets = prefs.getStringList('secrets') ?? [];

                int secretIndex = _secrets.indexOf(_filteredSecrets[index]);
                secrets[secretIndex] =
                    '${titleController.text},${descriptionController.text},${_filteredSecrets[index]['privacyLevel']},${_filteredSecrets[index]['timestamp']}';
                await prefs.setStringList('secrets', secrets);

                setState(() {
                  _secrets[secretIndex] = {
                    'title': titleController.text,
                    'description': descriptionController.text,
                    'privacyLevel': _filteredSecrets[index]['privacyLevel']!,
                    'timestamp': _filteredSecrets[index]['timestamp']!,
                  };
                  _filteredSecrets[index] = _secrets[secretIndex];
                });

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _viewSecret(int index) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(_filteredSecrets[index]['title']!),
          content: Text(_filteredSecrets[index]['description']!),
          actions: [
            IconButton(
              icon: Icon(Icons.copy, color: Colors.blue),
              onPressed: () {
                Clipboard.setData(ClipboardData(
                    text: _filteredSecrets[index]['description']!));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Secret copied to clipboard')),
                );
              },
            ),
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
          onChanged: _filterSecrets,
        ),
        backgroundColor: Color(0xff00233c),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: _filteredSecrets.isEmpty
          ? Center(
              child: Text(
                'No secrets saved yet',
                style: TextStyle(
                  color: Color(0xff00233c),
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              itemCount: _filteredSecrets.length,
              itemBuilder: (context, index) {
                // Determine text color for Privacy Level based on value
                Color privacyColor = Colors.black; // Default color
                switch (_filteredSecrets[index]['privacyLevel']) {
                  case 'High':
                    privacyColor = Colors.red;
                    break;
                  case 'Moderate':
                    privacyColor = Colors.orange;
                    break;
                  case 'Low':
                    privacyColor = Colors.green;
                    break;
                  default:
                    privacyColor = Colors.black; // Fallback
                }

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: Icon(Icons.security,
                              color: Color(0xff00233c)), // Icon color
                          title: Text(
                            _filteredSecrets[index]['title']!,
                            style: TextStyle(
                              color: Color(0xff00233c),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            '******',
                            style: TextStyle(color: Color(0xff00233c)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: privacyColor,
                                    size: 12,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    _filteredSecrets[index]['privacyLevel']!,
                                    style: TextStyle(
                                      color:
                                          privacyColor, // Apply determined color
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    _filteredSecrets[index]['timestamp']!,
                                    style: TextStyle(
                                      color: Colors
                                          .grey, // Grey color for timestamp
                                      fontStyle:
                                          FontStyle.italic, // Italic font style
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.visibility,
                                        color: Colors.blue),
                                    onPressed: () {
                                      _viewSecret(index);
                                    },
                                  ),
                                  IconButton(
                                    icon:
                                        Icon(Icons.edit, color: Colors.orange),
                                    onPressed: () {
                                      _editSecret(index);
                                    },
                                  ),
                                  if (_searchQuery.isEmpty)
                                    IconButton(
                                      icon:
                                          Icon(Icons.delete, color: Colors.red),
                                      onPressed: () {
                                        _deleteSecret(_secrets
                                            .indexOf(_filteredSecrets[index]));
                                      },
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
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
    home: ViewSecretsScreen(),
  ));
}
