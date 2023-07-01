import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_example/ui/authorization/sign_in/sign_in_page.dart';
import 'package:firebase_example/ui/home/home_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    FirebaseAuth auth = FirebaseAuth.instance;
    dynamic user = auth.currentUser;
    Future.delayed(const Duration(seconds: 3))
        .then((value) => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => user == null ? SingInPage() : HomePage(),
            ),
            (route) => false));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.blue,
        child: const Text('Welcome',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 32),),
      ),
    );
  }
}
