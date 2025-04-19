import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_flutter/provider/Listprovider.dart';

import 'adddata_list.dart';

class Listpage extends StatefulWidget {
  const Listpage({super.key});

  @override
  State<Listpage> createState() => _ListpageState();
}

class _ListpageState extends State<Listpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List"),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Consumer<ListProvider>(
        builder: (ctx, provider, abc) {
          return provider.getlist().isNotEmpty
              ? ListView.builder(
                itemCount: provider.getlist().length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(provider.getlist()[index]["name"]),
                    subtitle: Text(provider.getlist()[index]["phone"]),
                  );
                },
              )
              : Center(child: Text("data"));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => adddata_list()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
