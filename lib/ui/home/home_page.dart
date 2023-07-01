import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_example/data/models/mind_model.dart';
import 'package:firebase_example/ui/home/all_minds_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  TextEditingController mindCtrl = TextEditingController();
  TextEditingController authorCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllMindsPage(),
                    ));
              },
              icon: const Icon(Icons.next_plan))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const SizedBox(height: 32),
            TextField(
              controller: mindCtrl,
              decoration: const InputDecoration(
                  label: Text("Mind"), border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: authorCtrl,
              decoration: const InputDecoration(
                  label: Text("Author"), border: OutlineInputBorder()),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final db = FirebaseFirestore.instance;
          try {
            MindModel mind = MindModel(
                author: authorCtrl.text.trim(), mind: mindCtrl.text.trim());

            var myMind = await db.collection('minds').add(mind.toJson());
            db.collection("minds").doc(myMind.id).update({"docId": myMind.id});
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Sening fikring tarix zarvarag'iga bitildi!")));
            authorCtrl.clear();
            mindCtrl.clear();
          } catch (e) {}
        },
      ),
    );
  }
}
