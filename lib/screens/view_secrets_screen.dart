import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        _filteredSecrets = _secrets;
      });
    }
  }

  void _filterSecrets(String query) {
    setState(() {
      _searchQuery = query;
      _filteredSecrets = _secrets.where((secret) {
        return secret['title']!.toLowerCase().contains(query.toLowerCase()) ||
            secret['description']!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
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
          color: Colors.white, // Color of the back icon
        ),
      ),
      body: _filteredSecrets.isEmpty
          ? Center(
              child: Text(
                'No secrets saved yet',
                style: TextStyle(
                    color: Color(0xff00233c), fontWeight: FontWeight.bold),
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
                    child: ListTile(
                      leading: Icon(Icons.security,
                          color: Color(0xff00233c)), // Icon color
                      title: Text(
                        _filteredSecrets[index]['title']!,
                        style: TextStyle(
                          color: Color(0xff00233c),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _filteredSecrets[index]['description']!,
                            style: TextStyle(color: Color(0xff00233c)),
                          ),
                          Text(
                            'Privacy Level: ${_filteredSecrets[index]['privacyLevel']}',
                            style: TextStyle(
                                color: privacyColor), // Apply determined color
                          ),
                          Text(
                            'Added on: ${_filteredSecrets[index]['timestamp']}',
                            style: TextStyle(
                              color: Colors.grey, // Grey color for timestamp
                              fontStyle: FontStyle.italic, // Italic font style
                            ),
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
}
