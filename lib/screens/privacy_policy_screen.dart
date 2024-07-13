import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Privacy Policy',
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
              'Privacy Policy',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xff00233c),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Last updated: [12/07/2024]',
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Locker App ("we," "our," or "us") is committed to protecting your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application ("App"). By using the App, you agree to the terms of this Privacy Policy. If you do not agree with the terms of this Privacy Policy, please do not use the App.',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff00233c),
              ),
            ),
            SizedBox(height: 20),
            _buildSectionTitle('1. Information We Collect'),
            _buildSubSectionTitle('1.1 Personal Data'),
            _buildSectionContent(
                'We do not collect any personal data from users. All data stored within the App, such as logins, passwords, secret notes, payment cards, and online identities, is encrypted and stored locally on your device. We do not have access to this data.'),
            _buildSubSectionTitle('1.2 Non-Personal Data'),
            _buildSectionContent(
                'We may collect non-personal data that cannot be used to identify you. This may include information about your device, such as the device model, operating system version, and unique device identifiers. This data is collected to improve the performance and compatibility of the App.'),
            SizedBox(height: 20),
            _buildSectionTitle('2. How We Use Your Information'),
            _buildSubSectionTitle('2.1 Personal Data'),
            _buildSectionContent(
                'Since we do not collect personal data, we do not use it in any way. All sensitive information remains encrypted and stored locally on your device.'),
            _buildSubSectionTitle('2.2 Non-Personal Data'),
            _buildSectionContent(
                'Non-personal data may be used to:\n\n- Improve the performance and functionality of the App.\n- Ensure compatibility with various devices and operating systems.\n- Analyze usage trends and gather statistical information.'),
            SizedBox(height: 20),
            _buildSectionTitle('3. Information Sharing and Disclosure'),
            _buildSubSectionTitle('3.1 Personal Data'),
            _buildSectionContent(
                'We do not share, sell, or disclose your personal data to third parties because we do not collect it.'),
            _buildSubSectionTitle('3.2 Non-Personal Data'),
            _buildSectionContent(
                'We may share non-personal data with third-party service providers to help us analyze usage trends and improve the App\'s performance. These service providers are bound by confidentiality obligations and are not permitted to use the data for any other purpose.'),
            SizedBox(height: 20),
            _buildSectionTitle('4. Data Security'),
            _buildSectionContent(
                'We take data security seriously and implement appropriate technical and organizational measures to protect your information. Your data is encrypted using industry-standard encryption methods and is stored locally on your device. We do not have access to your data, and it is not transmitted over the internet.'),
            SizedBox(height: 20),
            _buildSectionTitle('5. Children\'s Privacy'),
            _buildSectionContent(
                'The App is not intended for use by children under the age of 13. We do not knowingly collect any personal data from children under 13. If we become aware that we have inadvertently collected personal data from a child under 13, we will take steps to delete such information from our records.'),
            SizedBox(height: 20),
            _buildSectionTitle('6. Changes to This Privacy Policy'),
            _buildSectionContent(
                'We may update this Privacy Policy from time to time to reflect changes in our practices or applicable laws. We will notify you of any significant changes by posting the updated Privacy Policy within the App or through other appropriate communication channels. Your continued use of the App after such changes constitutes your acceptance of the new Privacy Policy.'),
            SizedBox(height: 20),
            _buildSectionTitle('7. Contact Us'),
            _buildSectionContent(
                'If you have any questions or concerns about this Privacy Policy, please contact us at:\n\nEmail: futureapp999@gmail.com\n\n'),
            SizedBox(height: 20),
            Center(
              child: Text(
                'By using the Locker App, you acknowledge that you have read, understood, and agree to be bound by this Privacy Policy.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Color(0xff00233c),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xff00233c),
      ),
    );
  }

  Widget _buildSubSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xff00233c),
        ),
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Text(
        content,
        style: TextStyle(
          fontSize: 16,
          color: Color(0xff00233c),
        ),
      ),
    );
  }
}
