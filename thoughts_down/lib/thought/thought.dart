import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:thoughts_down/persist/db_model.dart';
import 'package:thoughts_down/persist/sqflite.dart';
import 'package:thoughts_down/common/datetime.dart';
import 'package:thoughts_down/persist/file.dart';
import 'package:thoughts_down/common/file.dart';
import 'dart:io';

class ThoughtsDisplayPage extends StatefulWidget {
  const ThoughtsDisplayPage({Key? key}) : super(key: key);

  @override
  State<ThoughtsDisplayPage> createState() => _ThoughtsDisplayPage();
}

class _ThoughtsDisplayPage extends State<ThoughtsDisplayPage>
    with TickerProviderStateMixin {
  List<Widget> getThoughtsData(List<Thought>? thoughts) {
    List<Widget> result = [];
    if (thoughts == null) {
      return result;
    }

    for (int i = 0; i < thoughts.length; i++) {
      List<String> imagePaths = [];
      result.add(ListTile(
        title: Text(
          thoughts[i].createTime,
          style: const TextStyle(color: Colors.black, fontSize: 10),
        ),
        subtitle: Text(
          thoughts[i].text,
          style: const TextStyle(color: Colors.blue, fontSize: 12),
          softWrap: true,
          // textAlign: TextAlign.start,
          overflow: TextOverflow.visible,
        ),
        minVerticalPadding: 0,
        horizontalTitleGap: 0,
      ));
      if (thoughts[i].imagePathsStr != null &&
          thoughts[i].imagePathsStr!.isNotEmpty) {
        imagePaths = thoughts[i].imagePathsStr!.split(",");
        for (int i = 0; i < imagePaths.length; i++) {
          result.add(
              Image.file(File(fileProcessor.tailorImagePath(imagePaths[i]))));
        }
      }
    }
    log("length=" + thoughts.length.toString());
    return result;
  }

  @override
  Widget build(BuildContext context) {
    Future<List<Thought>> loadDatas =
        thoughtManager.getThoughts(); // to make the list refresh everytime
    log("loadDatas...");
    return FutureBuilder<List<Thought>>(
      future: loadDatas,
      builder: (BuildContext context, AsyncSnapshot<List<Thought>> snapshot) {
        List<Widget> widgetChildren;
        if (snapshot.hasData) {
          log("has data");
          widgetChildren = getThoughtsData(snapshot.data);
        } else if (snapshot.hasError) {
          log("has error");
          widgetChildren = <Widget>[const Text("error!")];
        } else {
          log("waiting");
          widgetChildren = [const Text("waiting...")];
        }
        return ListView(
          children: widgetChildren,
        );
      },
    );
  }
}

class Thought {
  String text;
  String createTime;
  String? imagePathsStr;

  Thought(this.createTime, this.text, this.imagePathsStr);

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
  List<String> imagePathList = [];

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
        ElevatedButton(
            onPressed: () {
              Future<List<String?>> files = fileUploader.selectFiles();
              files.then((value) => {
                    for (int i = 0; i < value.length; i++)
                      {
                        if (value[i] != null) {imagePathList.add(value[i]!)}
                      }
                  });
            },
            child: const Text("select images")),
        TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          controller: _controller,
          autofocus: true,
          maxLines: 10000,
          minLines: 1,
          keyboardType: TextInputType.multiline,
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
      log("imagePathList" + imagePathList.toString());
      ThoughtModel thought = ThoughtModel(formatter.format(DateTime.now()),
          _controller.text, imagePathList.join(","));
      log("thoughts=" + thought.toMap().toString());
      sqfliteInstance.insertThought(thought);
      log("add file data");
      fileProcessor
          .appendData("\n" + thought.createTime + "\n" + thought.text + "\n");
      fileProcessor.appendData("<filePath>$imagePathList</filePath>\n");
      imagePathList = [];
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
      result.add(Thought(item.createTime, item.text, item.imagePathsStr));
    }
    return result;
  }
}
