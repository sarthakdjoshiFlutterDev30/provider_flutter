import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_flutter/Sqflite/notes.dart';
import 'package:provider_flutter/provider/CounterProvider.dart';
import 'package:provider_flutter/provider/Listprovider.dart';

import 'ListPage.dart';
import 'Sqflite/db_helper.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ListProvider()),
        ChangeNotifierProvider(create: (context) => CounterProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Notes(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    print("object");
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello"),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer(
            builder: (ctx, value, child) {
              return Text(
                //"${Provider.of<CounterProvider>(ctx, listen: true).getcount()}",
                "${ctx.read<CounterProvider>().getcount()}",
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              // Provider.of<CounterProvider>(context, listen: false).increment();
              context.read<CounterProvider>().increment();
            },
            child: Text("Add"),
          ),
          ElevatedButton(
            onPressed: () {
              //  Provider.of<CounterProvider>(context, listen: false).decrement();
              context.read<CounterProvider>().decrement();
            },
            child: Text("Sub"),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
