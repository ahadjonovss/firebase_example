import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_example/data/models/mind_model.dart';
import 'package:firebase_example/ui/home/widgets/mind_item.dart';
import 'package:flutter/material.dart';

class AllMindsPage extends StatefulWidget {
  const AllMindsPage({super.key});

  @override
  State<AllMindsPage> createState() => _AllMindsPageState();
}

class _AllMindsPageState extends State<AllMindsPage> {
  @override
  Widget build(BuildContext context) {
    getALlMinds() => FirebaseFirestore.instance.collection('minds').snapshots();

    return Scaffold(
      appBar: AppBar(title: const Text("All Minds Page")),
      body: StreamBuilder(
          stream: getALlMinds(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              List<MindModel> minds = snapshot.data!.docs
                  .map((e) => MindModel.fromJson(e.data()))
                  .toList();
              return ListView.builder(
                itemCount: minds.length,
                itemBuilder: (context, index) =>
                    MindItem(mind: minds[index]),
              );
            }
            return Container();
          }),
    );
  }
}
