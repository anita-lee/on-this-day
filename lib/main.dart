import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// Globe Image credit:
// <a href="https://www.flaticon.com/free-animated-icons/world" title="world animated icons">World animated icons created by Freepik - Flaticon</a>

// Global variables
var factText = '';
var dateText = '';

// Defining the Fact Class and serializing it
class Fact {
  Fact({
    this.number,
    this.source,
    this.text,
    this.year,
  });

  int? number;
  String? source;
  String? text;
  int? year;

  factory Fact.fromJson(Map<String, dynamic> json) {
    return Fact(
      number: json["number"],
      source: json["source"],
      text: json["text"],
      year: json["year"],
    );
  }
}

// Async function that calls the API for user-inputted Date/Day fact
Future<Fact> fetchFact(String text) async {
  String url = "http://numbersapi.com/$text/date?json";

  final response = await http.get(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"});

  if (response.statusCode == 200) {
    return Fact.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load fact');
  }
}

// Async function that calls the API for random date fact
Future<Fact> fetchRandomFact() async {
  String url = "http://numbersapi.com/random/date?json";

  final response = await http.get(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"});

  if (response.statusCode == 200) {
    return Fact.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load fact');
  }
}

// Runs the app
void main() => runApp(const MyApp());


// Conductor that builds App
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Retrieve Text Input',
      home: MyCustomApp(),
    );
  }
}

// Define a custom widget with state.
class MyCustomApp extends StatefulWidget {
  const MyCustomApp({super.key});


  @override
  _MyCustomAppState createState() => _MyCustomAppState();
}

// Define a corresponding State class.
class _MyCustomAppState extends State<MyCustomApp> {

  // Update Fact state
  void updateFact(newFact) {
    setState(() {
      factText = newFact;
    });
  }

  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();

  // Saves value from text box and saves it to dateText variable
  void _setText() {
    setState(() {
      dateText = myController.text;
    });
  }

  // Text Section widget for "What happened on this day in history?"
  Widget textSection = const Align(
      alignment: Alignment.center,
      child: Text(
        'What happened on this day in history?',
        style: TextStyle(fontSize: 15),
        softWrap: true,
      ));

  //Build App
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // On This Day Section
      appBar: AppBar(
        title: const Text('On This Day'),
      ),

      // Date text field Section
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: myController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Date MM/DD',
            ),
          ),
        ),

        // Globe Image Section
        Container(
            padding: const EdgeInsets.only(top: 30, bottom: 30),
            child: Image.asset(
              'images/globe-earth.gif',
              width: 100,
              height: 100,
            )),

        // What happened on this day? Section
        Container(padding: const EdgeInsets.only(top: 20), child: textSection),

        // Fact Block Section
        Align(
            alignment: Alignment.center,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 70,
                  child: Text('${factText}')
                )
            )
        ),

        Center(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget> [

                // Search Button
                const SizedBox(height: 30),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color(0xFF0D47A1),
                                Color(0xFF1976D2),
                                Color(0xFF42A5F5),
                              ],
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.only(top: 16.0, bottom: 16.0, left: 22.0, right: 22.0),
                            primary: Colors.white,
                            textStyle: const TextStyle(fontSize: 20)),
                        onPressed: () async {
                          var result = await fetchFact(myController.text);
                          factText = result.text as String;
                          updateFact(factText);
                          myController.text="";
                        },
                        child: const Text('Search'),
                      ),
                    ],
                  ),
                ),

                // Random Button
                const SizedBox(height: 30),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(

                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color(0xFF0D47A1),
                                Color(0xFF1976D2),
                                Color(0xFF42A5F5),
                              ],
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(16.0),
                          primary: Colors.white,
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        onPressed: () async {
                          var result = await fetchRandomFact();
                          factText = result.text as String;
                          updateFact(factText);
                        },
                        child: const Text('Random'),
                      ),
                    ],
                  ),
                ),
              ]
          )
        ),
      ]),
    );
  }
}
