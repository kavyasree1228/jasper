import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jasper/sign_in_screen.dart';
// import 'auth_services.dart';
// import 'weight_entry_form.dart';
// import 'weight_entry_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDfKGMKZpEdAJ1CI6raWOSGzOOgqzbRKvQ',
      authDomain: 'jasper-31602.firebaseapp.com',
      projectId: 'jasper-31602',
      storageBucket: 'gs://jasper-31602.appspot.com',
      messagingSenderId: '851048394071',
      appId: '1:851048394071:ios:e33cfb2d0a4a8566892212',
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weight Watchers',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignInScreen(),
    );
  }
}
