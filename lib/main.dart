import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Лоскутникова Анна Алексеевна'), 
          backgroundColor: Colors.blue, 
        ),
        body: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'ФИО: Лоскутникова Анна Алексеевна', 
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0), 
            child: Text(
              'Год рождения: 2005', 
              style: const TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                color: Colors.black87,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0), 
            child: Text(
              'Группа: зИСТУ-23', 
              style: const TextStyle(
                fontSize: 20,
                color: Colors.green,
                letterSpacing: 1.5,
              ),
            ),
          ),

        ],
      ),
    );
  }
}