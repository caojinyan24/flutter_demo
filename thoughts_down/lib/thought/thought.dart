import 'package:flutter/material.dart';
import 'package:thoughts_down/persist/db_model.dart';
import 'package:thoughts_down/common/variable.dart';

List<Thought> savedThoughts =[];

class ThoughtsDisplayPage extends StatefulWidget {
  const ThoughtsDisplayPage({Key? key}) : super(key: key);

  @override
  State<ThoughtsDisplayPage> createState() => _ThoughtsDisplayPage();
}

class _ThoughtsDisplayPage extends State<ThoughtsDisplayPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    savedThoughts = getAllThoughtsFromDb();
    print("saved thoughts=");
    print(savedThoughts);
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

  List<Thought> getAllThoughtsFromDb() {
    List<Thought> result=[] ;
    final Future<List<ThoughtModel>> thoughts = sqfliteInstance.thoughts();
    print("future thoughts=");
    print(thoughts.toString());
    thoughts.then((value) => {
      for (ThoughtModel item in value){
        print("item.text="+item.text),
        result.add(Thought(createTime: item.createTime, text: item.text)),
        print("after insert="+item.text),

      }
    });
    print("result=");
    print(result);
    return result;
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