import 'package:flutter/material.dart';
import 'thought/thought.dart';
import 'thought/add_thought.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const ThoughtsDownApp());
}

class ThoughtsDownApp extends StatelessWidget {
  //APP
  const ThoughtsDownApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   return MultiProvider(
    //       providers: [
    //         Provider(create: (context) => const ThoughtsDownHomePage()),
    //         Provider(create: (context) => ThoughtsEditHomePage()),
    //       ],
    //
    //       child: MaterialApp(
    //           title: 'thoughts down',
    //           theme: ThemeData(
    //             primarySwatch: Colors.blue,
    //           ),
    //
    //           // home: const ThoughtsDownHomePage(),
    //           routes: {
    //             '/': (context) => const ThoughtsDownHomePage(),
    //             '/thoughtsEdit': (context) => ThoughtsEditHomePage(),
    //           }));
    // }
    return MaterialApp(
      title: "thoughts down",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ThoughtsDownHomePage(),
      routes: {
        '/home': (context) => const ThoughtsDownHomePage(),
        '/thoughtsEdit': (context) => ThoughtsEditHomePage(),
      },
    );
  }
}

class ThoughtsDownHomePage extends StatefulWidget {
  //homePage
  const ThoughtsDownHomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  // final String title;

  @override
  State<ThoughtsDownHomePage> createState() => _ThoughtsDownHomePageState();
}

class _ThoughtsDownHomePageState extends State<ThoughtsDownHomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          // title: Text(widget.title),
          ),
      body: const ThoughtsDisplayPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.airplay),
              label: "Thoughts",
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.access_alarm),
              label: "ToDos",
              backgroundColor: Colors.blue),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, "/thoughtsEdit"),
        child: const Icon(Icons.add),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
