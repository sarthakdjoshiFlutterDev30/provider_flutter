import 'package:flutter/material.dart';

import 'db_helper.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  DbHelper dbhelper = DbHelper.instance;
  String dbName = 'User .db'; // Default database name

  Future<List<Map<String, dynamic>>> getNotes() async {
    return await dbhelper.getallnotes(dbName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getNotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No Notes"));
          } else {
            List<Map<String, dynamic>> notes = snapshot.data!;
            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(notes[index]["s_no"].toString()),
                  ),
                  title: Text(notes[index]["title"]),
                  subtitle: Text(notes[index]["description"]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          dbhelper.deleteNote(notes[index]["s_no"], dbName);
                          setState(() {}); // Refresh the notes list
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          String title = notes[index]["title"];
                          String description = notes[index]["description"];

                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Edit Note"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      decoration: InputDecoration(
                                        labelText: "Title",
                                      ),
                                      controller: TextEditingController(
                                        text: title,
                                      ),
                                      onChanged: (value) {
                                        title = value;
                                      },
                                    ),
                                    TextField(
                                      decoration: InputDecoration(
                                        labelText: "Description",
                                      ),
                                      controller: TextEditingController(
                                        text: description,
                                      ),
                                      onChanged: (value) {
                                        description = value;
                                      },
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      if (title.isNotEmpty &&
                                          description.isNotEmpty) {
                                        await dbhelper.updateNote(
                                          notes[index]["s_no"],
                                          title,
                                          description,
                                          dbName,
                                        );
                                        Navigator.of(context).pop();
                                        setState(
                                          () {},
                                        ); // Refresh the notes list
                                      }
                                    },
                                    child: Text("Update"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNote,
        child: Icon(Icons.add),
      ),
    );
  }

  void addNote() async {
    String title = ""; // Get title from user input
    String description = ""; // Get description from user input

    // Show dialog to get user input
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Note"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                onChanged: (value) {
                  title = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: "Description"),
                onChanged: (value) {
                  description = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                if (title.isNotEmpty && description.isNotEmpty) {
                  await dbhelper.addnotes(title, description, dbName);
                  Navigator.of(context).pop();
                  setState(() {}); // Refresh the notes list
                }
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }
}
