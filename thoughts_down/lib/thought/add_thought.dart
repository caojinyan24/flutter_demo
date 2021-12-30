import 'package:flutter/material.dart';
import 'package:thoughts_down/thought/thought.dart';

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
    //TODO： 这里需要做成只能提交一次，提交后返回到首页
    setState(() {
        savedThoughts
            .add(Thought(createTime: DateTime.now(), text: _controller.text));
    });
    Navigator.pop(context);
  }
}
