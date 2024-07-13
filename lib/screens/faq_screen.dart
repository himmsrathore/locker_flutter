import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FAQ',
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Locker App FAQ',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xff00233c),
              ),
            ),
            SizedBox(height: 20),
            _buildSectionTitle('General Questions'),
            _buildQuestion('1. What is the Locker App?'),
            _buildAnswer(
                'The Locker App is a secure, cross-platform vault designed to store and manage your sensitive information, such as logins, passwords, secret notes, payment cards, and online identities. It provides a safe and user-friendly environment to keep your data encrypted and accessible only via a master password or PIN.'),
            _buildQuestion('2. Is the Locker App free to use?'),
            _buildAnswer(
                'Yes, the Locker App is free to download and use. However, there may be additional features or premium services offered in the future.'),
            _buildQuestion(
                '3. On which platforms is the Locker App available?'),
            _buildAnswer(
                'The Locker App is available on both iOS and Android platforms, providing a seamless experience across different devices.'),
            SizedBox(height: 20),
            _buildSectionTitle('Security and Privacy'),
            _buildQuestion(
                '4. How does the Locker App ensure my data is secure?'),
            _buildAnswer(
                'The Locker App uses advanced encryption techniques to protect your data. Your information is stored locally on your device and is encrypted using a master password or PIN that only you know. This ensures that even if your device is accessed by unauthorized parties, your data remains secure.'),
            _buildQuestion('5. Does the Locker App require internet access?'),
            _buildAnswer(
                'No, the Locker App does not require internet access to function. All your data is stored locally on your device, ensuring maximum security and privacy.'),
            _buildQuestion(
                '6. Can the Locker App access my stored information?'),
            _buildAnswer(
                'No, the Locker App does not have access to your stored information. All data is encrypted and stored locally on your device, and only you can decrypt it using your master password or PIN.'),
            _buildQuestion(
                '7. What happens if I forget my master password or PIN?'),
            _buildAnswer(
                'If you forget your master password or PIN, there is no way to recover it due to the encryption methods used. You will need to reset the app, which will delete all stored data, and then set up the app again.'),
            SizedBox(height: 20),
            _buildSectionTitle('Features'),
            _buildQuestion('8. How do I add a new password or note?'),
            _buildAnswer(
                'To add a new password or note, simply navigate to the home screen and tap the "Add" button. You can then enter the relevant information and save it. The data will be encrypted and stored securely on your device.'),
            _buildQuestion('9. Does the Locker App support password autofill?'),
            _buildAnswer(
                'Yes, the Locker App supports password autofill for a seamless browsing experience. You can enable this feature in the app settings.'),
            _buildQuestion(
                '10. Can I share my stored information with others?'),
            _buildAnswer(
                'Yes, the Locker App includes a secure item sharing feature that allows you to share selected information with others. The shared data is encrypted and can only be accessed by the intended recipient.'),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xff00233c),
      ),
    );
  }

  Widget _buildQuestion(String question) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        question,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xff00233c),
        ),
      ),
    );
  }

  Widget _buildAnswer(String answer) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        answer,
        style: TextStyle(
          fontSize: 16,
          color: Color(0xff00233c),
        ),
      ),
    );
  }
}
