// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_example/ui/authorization/sign_in/sign_in_page.dart';
import 'package:firebase_example/ui/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SingInPage(),
                    ));
              },
              icon: const Icon(Icons.add))
        ],
        title: const Text("Sing Up Page"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text("Shaxsiy hisobingizni yarating"),
            const SizedBox(height: 32),
            TextField(
              controller: email,
              decoration: const InputDecoration(
                  label: Text("Email"), border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: password,
              decoration: const InputDecoration(
                  label: Text("Password"), border: OutlineInputBorder()),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try{
            await auth.createUserWithEmailAndPassword(
                email: email.text.trim(), password: password.text.trim());
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(),), (route) => false);
          }catch(e){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
          }
        },
        child: const Icon(Icons.login),
      ),
    );
  }
}
