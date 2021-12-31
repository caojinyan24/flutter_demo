import 'package:flutter/material.dart';
import 'package:thoughts_down/thought/thought.dart';
import 'package:thoughts_down/common/variable.dart';
import 'package:thoughts_down/persist/db_model.dart';

class ThoughtsEditHomePage extends StatelessWidget {
  const ThoughtsEditHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: const [
          Text("thoughts edit"),
        ],
      )),
      body: const ThoughtsEditState(),
    );
  }
}

class ThoughtsEditState extends StatefulWidget {
  const ThoughtsEditState({Key? key}) : super(key: key);

  @override
  _ThoughtsEditState createState() => _ThoughtsEditState();
}

class _ThoughtsEditState extends State<ThoughtsEditState> {
  final _controller = TextEditingController();
  String textInput = "";

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        textInput = _controller.text;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          controller: _controller,
        ),
        ElevatedButton(
          child: const Text("Done!"),
          onPressed: _submitThoughtsData,
        ),
      ],
    );
  }

  void _submitThoughtsData() {
    setState(() {
      ThoughtModel thought =
          ThoughtModel(DateTime.now().toIso8601String(), _controller.text);
      savedThoughts.add(Thought(
          createTime: DateTime.now().toIso8601String(),
          text: _controller.text));
      Future<int> count = sqfliteInstance.insertThought(thought);
      print("begin to insert");
      var insertedCount = 0;
      count.then((value) => insertedCount);
      print(insertedCount);
    });
    Navigator.pop(context);
  }
}
