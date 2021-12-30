import 'package:flutter/material.dart';

class ThoughtsEditHomePage extends StatelessWidget {
  const ThoughtsEditHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: const [
          // IconButton(
          //     onPressed: () => Navigator.pushNamed(context, "/"),
          //     icon: const Icon(Icons.arrow_back_sharp)),
          Text("thoughts edit"),
        ],
      )),
      body: Row(
        children: [
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter a search term',
            ),
          ),
          IconButton(
              onPressed: _submitThoughtsData, icon: const Icon(Icons.forward))
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _selectedIndex,
      //   onTap: _onItemTapped,
      //   items: const [
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.airplay),
      //         label: "Thoughts",
      //         backgroundColor: Colors.blue),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.access_alarm),
      //         label: "ToDos",
      //         backgroundColor: Colors.blue),
      //   ],
      // ),
    );
  }

  void _submitThoughtsData() {

  }
}
