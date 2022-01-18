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
  void initState() {
    super.initState();
    print("init state");
  }

  List<Widget> getThoughtsData(List<Thought>? thoughts) {
    List<Widget> result = [];
    if (thoughts == null) {
      return result;
    }
    for (int i = 0; i < thoughts.length; i++) {
      result.add(Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              thoughts[i].createTime,
              style: const TextStyle(color: Colors.black, fontSize: 10),
            ),
          ),
        ],
      ));
      result.add(Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              thoughts[i].text,
              style: const TextStyle(color: Colors.blue, fontSize: 12),
              softWrap: true,
              textAlign: TextAlign.start,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ));
    }
    print("length=" + thoughts.length.toString());
    return result;
  }

  @override
  Widget build(BuildContext context) {
    Future<List<Thought>> loadDatas =
        thoughtManager.getThoughts(); // to make the list refresh everytime
    print("loadDatas...");
    return FutureBuilder<List<Thought>>(
      future: loadDatas,
      builder: (BuildContext context, AsyncSnapshot<List<Thought>> snapshot) {
        List<Widget> widgetChildren;
        if (snapshot.hasData) {
          print("has data");
          widgetChildren = getThoughtsData(snapshot.data);
        } else if (snapshot.hasError) {
          print("has error");
          widgetChildren = <Widget>[const Text("error!")];
        } else {
          print("waiting");
          widgetChildren = [const Text("waiting...")];
        }
        return Column(
          children: widgetChildren,
        );
      },
    );
  }
}

class Thought {
  String text;
  String createTime;

  Thought(this.createTime, this.text);

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
          autofocus: true,
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
      sqfliteInstance.insertThought(thought);
    });
    Navigator.pop(context);
  }
}

var thoughtManager = ThoughtManager();

class ThoughtManager {
  List<Thought> savedThoughts = [];

  Future<List<Thought>> getThoughts() async {
    List<Thought> result = [];
    List<ThoughtModel> thoughts = await sqfliteInstance.thoughts();
    for (ThoughtModel item in thoughts) {
      result.add(Thought(item.createTime, item.text));
    }
    return result;
  }
}
