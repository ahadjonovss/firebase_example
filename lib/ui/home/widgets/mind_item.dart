import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_example/data/models/mind_model.dart';
import 'package:flutter/material.dart';

class MindItem extends StatefulWidget {
  MindModel mind;
  MindItem({ required this.mind, super.key});

  @override
  State<MindItem> createState() => _MindItemState();
}

class _MindItemState extends State<MindItem> {
  TextEditingController mindCtrl = TextEditingController();

  TextEditingController authorCtrl = TextEditingController();

  @override
  void initState() {
    mindCtrl.text = widget.mind.mind;
    authorCtrl.text = widget.mind.author;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.mind.mind),
      subtitle: Text(widget.mind.author),
      leading: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          final db = FirebaseFirestore.instance;
          db.collection("minds").doc(widget.mind.docId).delete();
        },
      ),
      trailing: IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    content: Container(
                      height: 270,
                      padding: const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          const SizedBox(height: 32),
                          TextField(
                            controller: mindCtrl,
                            decoration: const InputDecoration(
                                label: Text("Mind"),
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: authorCtrl,
                            decoration: const InputDecoration(
                                label: Text("Author"),
                                border: OutlineInputBorder()),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel")),
                      TextButton(
                          onPressed: () {
                            final db = FirebaseFirestore.instance;
                            print(widget.mind.toJson());
                            widget.mind.author = authorCtrl.text.trim();
                            widget.mind.mind = mindCtrl.text.trim();
                            db
                                .collection("minds")
                                .doc(widget.mind.docId)
                                .update(widget.mind.toJson());
                            Navigator.pop(context);
                          },
                          child: const Text("Update")),
                    ],
                  ));
        },
        icon: const Icon(Icons.edit),
      ),
    );
  }
}
