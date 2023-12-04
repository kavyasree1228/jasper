import 'package:flutter/material.dart';
import 'package:jasper/auth_services.dart';
import 'package:jasper/weight_entry_form.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  Future<void> _signIn() async {
    await AuthService().signInAnonymously();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => WeightEntryForm()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Weight Watchers'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Please sign in to get started'),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                _signIn();
              },
              child: Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
