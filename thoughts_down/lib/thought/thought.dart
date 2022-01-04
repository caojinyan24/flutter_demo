import 'package:flutter/material.dart';
import 'package:thoughts_down/persist/db_model.dart';
import 'package:thoughts_down/common/variable.dart';
import 'package:thoughts_down/common/datetime.dart';


class ThoughtsDisplayPage extends StatefulWidget {
  const ThoughtsDisplayPage({Key? key}) : super(key: key);

  @override
  State<ThoughtsDisplayPage> createState() => _ThoughtsDisplayPage();
}

class _ThoughtsDisplayPage extends State<ThoughtsDisplayPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    thoughtManager.refresh();
    return Row(
      children: [
        Flexible(
          child: ListView.builder(
            itemBuilder: (_, index) => thoughtManager.savedThoughts[index],
            itemCount: thoughtManager.savedThoughts.length,
          ),
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
        ),
      ],
    );
  }
}

class Thought extends StatelessWidget {
  const Thought({
    required this.createTime,
    required this.text,
    Key? key,
  }) : super(key: key);
  final String text;
  final String createTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // const Divider(height: 10.0),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(createTime),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: Text(
                text,
                style: const TextStyle(
                    color: Colors.blue,
                    fontStyle: FontStyle.normal,
                    fontSize: 20),
              ),
            )
          ],
        )),
      ],
    );
  }

  static String convertTime(DateTime time) {
    return time.year.toString() +
        " " +
        time.month.toString() +
        " " +
        time.day.toString();
  }
}


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
      ThoughtModel(formatter.format(DateTime.now()), _controller.text);
      thoughtManager.savedThoughts.add(Thought(
          createTime: formatter.format(DateTime.now()),
          text: _controller.text));
      sqfliteInstance.insertThought(thought);
    });
    Navigator.pop(context);
  }
}




var thoughtManager = ThoughtManager();

class ThoughtManager {
  List<Thought> savedThoughts = [];

  ThoughtManager() {
    print("init Thought list");
    getThoughtList();
  }

  void getThoughtList() {
    List<Thought> result = [];
    Future<List<ThoughtModel>> thoughts = sqfliteInstance.thoughts();
    thoughts.then((value) => {
      for (ThoughtModel item in value)
        {
          result.add(Thought(createTime: item.createTime, text: item.text)),
        },
      savedThoughts = result,
    });
  }

  void refresh() {
    getThoughtList();
  }
}
