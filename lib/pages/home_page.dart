import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textController = TextEditingController();


  void openNoteBox({String? docID}) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: TextField(
            controller: textController,
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  if (docID == null) {

                  } else {

                  }
                  textController.clear();
                  Navigator.pop(context);
                },
                child: const Text('Add')
            )
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: GestureDetector(
          onTap: openNoteBox,
          child: Container(
            padding:  const EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.blueGrey[100]
            ),
            child: Text(
              'Добавить',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[700],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[100],
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.blueGrey[700],
        ),
      ),
      drawer: Drawer(
        elevation: 0,
        backgroundColor: Colors.blueGrey[50],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: null,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List notesList = snapshot.data!.docs;
            return ListView.builder(
                itemCount: notesList.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = notesList[index];
                  String docID = document.id;

                  Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
                  String noteText = data['info'];

                  return Padding(
                    padding: const EdgeInsets.all(12),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.blueGrey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(noteText),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () => openNoteBox(docID: docID),
                                icon: const Icon(Icons.settings)
                            ),
                            IconButton(
                                onPressed: () => null,
                                icon: const Icon(Icons.delete, color: Colors.redAccent)
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
            );
          } else {
            return const Text('no notes..');
          }
        },
      ),
    );
  }
}