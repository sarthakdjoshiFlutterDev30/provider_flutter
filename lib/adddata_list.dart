import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_flutter/provider/Listprovider.dart';

class adddata_list extends StatelessWidget {
  const adddata_list({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List"),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: FloatingActionButton(
          onPressed: () {
            context.read<ListProvider>().add({
              "name": "hello",
              "phone": "98897478785",
            });
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
