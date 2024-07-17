import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

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

        // Sort by timestamp in descending order
        _secrets.sort((a, b) => b['timestamp']!.compareTo(a['timestamp']!));

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
          return secret['title']!.toLowerCase().contains(query.toLowerCase()) ||
              secret['description']!
                  .toLowerCase()
                  .contains(query.toLowerCase());
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
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue[50], // Background color
                  border: Border.all(color: Colors.blue), // Border color
                  borderRadius: BorderRadius.circular(8.0), // Rounded corners
                ),
                padding: EdgeInsets.all(8.0), // Padding inside the container
                margin: EdgeInsets.symmetric(
                    vertical: 4.0), // Margin outside the container
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: InputBorder.none, // Remove default border
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue[50], // Background color
                  border: Border.all(color: Colors.blue), // Border color
                  borderRadius: BorderRadius.circular(8.0), // Rounded corners
                ),
                padding: EdgeInsets.all(8.0), // Padding inside the container
                margin: EdgeInsets.symmetric(
                    vertical: 4.0), // Margin outside the container
                child: TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: InputBorder.none, // Remove default border
                  ),
                  maxLines: null, // Allows the TextField to be multiline
                  keyboardType:
                      TextInputType.multiline, // Enables multiline input
                ),
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: _filteredSecrets.isEmpty
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
                      elevation: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: privacyColor, // Privacy color
                              ),
                            ),
                            title: Text(
                              _filteredSecrets[index]['title']!,
                              style: TextStyle(
                                color: Color(0xff00233c),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '*******',
                              style: TextStyle(color: Color(0xff00233c)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    // IconButton(
                                    //   icon: Icon(Icons.lock_clock,
                                    //       color: const Color.fromARGB(
                                    //           255, 139, 139, 139)),
                                    //   onPressed: () {
                                    //     _viewSecret(index);
                                    //   },
                                    // ),
                                    SizedBox(width: 10),
                                    Text(
                                      _filteredSecrets[index]['timestamp']!,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 9, // Font size for timestamp
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
                                      icon: Icon(Icons.edit,
                                          color: Colors.orange),
                                      onPressed: () {
                                        _editSecret(index);
                                      },
                                    ),
                                    if (_searchQuery.isEmpty)
                                      IconButton(
                                        icon: Icon(Icons.delete,
                                            color: Colors.red),
                                        onPressed: () {
                                          _deleteSecret(_secrets.indexOf(
                                              _filteredSecrets[index]));
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
