# 2021-12-30
全局变量，类之间变量的传递
StatefulWidget和StatelessWidget区别：
MaterialApp是最顶级的app基本的widget；Scaffold

ElevatedButton
IconButton
TextButton
```aidl
TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Buying not supported yet.')));
              },
              style: TextButton.styleFrom(primary: Colors.white),
              child: const Text('BUY'),
```

下划线命名和非下划线命名的区别

done: add a "add" interaction, edit page, add data and display
to be done: save data to local disk(https://docs.flutter.dev/cookbook/persistence)