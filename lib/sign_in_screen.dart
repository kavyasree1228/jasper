import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jasper/weight_entry_form.dart';
import 'package:jasper/weight_entry_screen.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

Future<void> signInAnonymously(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signInAnonymously();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => WeightEntryScreen()),
    );
  } catch (e) {
    print(e.toString());
  }
}

class _SignInScreenState extends State<SignInScreen> {
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
                await signInAnonymously(context);
              },
              child: Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
