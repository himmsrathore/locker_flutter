import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home_screen.dart';
import 'screens/register_screen.dart';
import 'screens/login_screen.dart';
import 'screens/locker_screen.dart';
import 'screens/add_password_screen.dart';
import 'screens/view_passwords_screen.dart';
import 'screens/add_secret_screen.dart';
import 'screens/view_secrets_screen.dart';
import 'screens/privacy_policy_screen.dart';
import 'screens/terms_conditions_screen.dart';
import 'screens/about_us_screen.dart';
import 'screens/faq_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Password Keeper',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/register': (context) => RegisterScreen(),
        '/login': (context) => LoginScreen(),
        '/locker': (context) => LockerScreen(),
        '/add_password': (context) => AddPasswordScreen(),
        '/view_passwords': (context) => ViewPasswordsScreen(),
        '/add_secret': (context) => AddSecretScreen(),
        '/view_secrets': (context) => ViewSecretsScreen(),
        '/privacy_policy': (context) => PrivacyPolicyScreen(),
        '/terms_conditions': (context) => TermsConditionsScreen(),
        '/about_us': (context) => AboutUsScreen(),
        '/faq': (context) => FAQScreen(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkRegistrationStatus();
  }

  Future<void> _checkRegistrationStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isRegistered = prefs.containsKey('pin');

    if (isRegistered) {
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
