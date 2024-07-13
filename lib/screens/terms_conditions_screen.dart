import 'package:flutter/material.dart';

class TermsConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Terms and Conditions',
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
              'Locker App Terms and Conditions',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xff00233c),
              ),
            ),
            SizedBox(height: 20),
            _buildSectionTitle('Last updated: 12/07/2024'),
            SizedBox(height: 10),
            _buildSectionTitle('1. Introduction'),
            _buildContent(
                'Welcome to Locker App ("we," "our," or "us"). These Terms and Conditions govern your use of our mobile application ("App") available on the Google Play Store. By downloading, installing, or using the App, you agree to these Terms and Conditions. If you do not agree with these Terms and Conditions, please do not use the App.'),
            SizedBox(height: 10),
            _buildSectionTitle('2. Use of the App'),
            _buildSubsectionTitle('2.1 Eligibility'),
            _buildContent(
                'You must be at least 18 years old to use the App. By using the App, you represent and warrant that you are at least 18 years of age and have the legal capacity to enter into these Terms and Conditions.'),
            _buildSubsectionTitle('2.2 License'),
            _buildContent(
                'We grant you a limited, non-exclusive, non-transferable, and revocable license to use the App for personal, non-commercial purposes, subject to these Terms and Conditions.'),
            _buildSubsectionTitle('2.3 Restrictions'),
            _buildContent(
                'You agree not to:\n\n• Use the App for any illegal or unauthorized purpose.\n• Modify, reverse engineer, decompile, or disassemble the App.\n• Interfere with or disrupt the integrity or performance of the App.\n• Use the App to transmit any harmful or malicious code.\n• Use the App to infringe on the rights of others.'),
            SizedBox(height: 10),
            _buildSectionTitle('3. User Accounts'),
            _buildSubsectionTitle('3.1 Account Creation'),
            _buildContent(
                'To use certain features of the App, you may need to create an account. You agree to provide accurate and complete information when creating your account and to keep this information up-to-date.'),
            _buildSubsectionTitle('3.2 Account Security'),
            _buildContent(
                'You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account. You agree to notify us immediately of any unauthorized use of your account.'),
            SizedBox(height: 10),
            _buildSectionTitle('4. Privacy'),
            _buildContent(
                'Your privacy is important to us. Please review our Privacy Policy, which explains how we collect, use, and disclose information about you.'),
            SizedBox(height: 10),
            _buildSectionTitle('5. Data Security'),
            _buildContent(
                'The App stores your data locally on your device and uses encryption to protect your information. We do not have access to your data. However, you are responsible for maintaining the security of your device and the confidentiality of your master password or PIN.'),
            SizedBox(height: 10),
            _buildSectionTitle('6. Intellectual Property'),
            _buildContent(
                'All intellectual property rights in the App, including but not limited to software, design, and content, are owned by us or our licensors. You agree not to copy, distribute, modify, or create derivative works of the App or any part of it without our prior written consent.'),
            SizedBox(height: 10),
            _buildSectionTitle('7. Disclaimers'),
            _buildSubsectionTitle('7.1 No Warranty'),
            _buildContent(
                'The App is provided on an "as-is" and "as-available" basis. We make no warranties or representations, express or implied, about the App, including but not limited to its accuracy, reliability, completeness, or suitability for any purpose.'),
            _buildSubsectionTitle('7.2 Limitation of Liability'),
            _buildContent(
                'To the fullest extent permitted by law, we disclaim all liability for any direct, indirect, incidental, consequential, or special damages arising out of or in connection with your use of the App.'),
            SizedBox(height: 10),
            _buildSectionTitle('8. Modifications to the App and Terms'),
            _buildContent(
                'We reserve the right to modify or discontinue the App at any time without notice. We may also update these Terms and Conditions from time to time. Your continued use of the App after any such changes constitutes your acceptance of the new Terms and Conditions.'),
            SizedBox(height: 10),
            _buildSectionTitle('9. Termination'),
            _buildContent(
                'We may terminate or suspend your access to the App at any time, without prior notice or liability, for any reason, including if you breach these Terms and Conditions.'),
            SizedBox(height: 10),
            _buildSectionTitle('10. Governing Law'),
            _buildContent(
                'These Terms and Conditions are governed by and construed in accordance with the laws of India, without regard to its conflict of law principles.'),
            SizedBox(height: 10),
            _buildSectionTitle('11. Contact Us'),
            _buildContent(
                'If you have any questions or concerns about these Terms and Conditions, please contact us at:\n\nEmail: [futureapp999@gmail.com]\n'),
            SizedBox(height: 10),
            _buildContent(
                'By using the Locker App, you acknowledge that you have read, understood, and agree to be bound by these Terms and Conditions.'),
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

  Widget _buildSubsectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xff00233c),
        ),
      ),
    );
  }

  Widget _buildContent(String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
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
