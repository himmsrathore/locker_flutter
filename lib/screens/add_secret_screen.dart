import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class AddSecretScreen extends StatefulWidget {
  @override
  _AddSecretScreenState createState() => _AddSecretScreenState();
}

class _AddSecretScreenState extends State<AddSecretScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  String _privacyLevel = 'High';
  final List<String> _privacyLevels = ['High', 'Moderate', 'Low'];

  Future<void> _saveSecret() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String timestamp =
          DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());

      List<String>? secrets = prefs.getStringList('secrets') ?? [];
      secrets.add('$_title,$_description,$_privacyLevel,$timestamp');
      await prefs.setStringList('secrets', secrets);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Secret added successfully')),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Your Secret',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                ),
                maxLines: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _privacyLevel,
                decoration: InputDecoration(
                  labelText: 'Privacy Level',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    _privacyLevel = newValue!;
                  });
                },
                items: _privacyLevels.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveSecret,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff00233c), // background
                  foregroundColor: const Color.fromARGB(255, 255, 255, 255),

                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: Text('Add Secret'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
