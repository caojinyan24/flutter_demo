import 'package:flutter/material.dart';

List<Thought> savedThoughts = [];

class ThoughtsDisplayPage extends StatefulWidget {
  const ThoughtsDisplayPage({Key? key}) : super(key: key);

  @override
  State<ThoughtsDisplayPage> createState() => _ThoughtsDisplayPage();
}

class _ThoughtsDisplayPage extends State<ThoughtsDisplayPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: ListView.builder(
            itemBuilder: (_, index) => savedThoughts[index],
            itemCount: savedThoughts.length,
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
  final DateTime createTime;

  Map<String, dynamic> toMap() {
    return {
      'create_time': createTime,
      'text': text,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // const Divider(height: 10.0),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(convertTime(createTime)),
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
