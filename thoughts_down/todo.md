# 2021-12-31
await关键字？？
dart void 修饰符
sqflite自增ID：


INT PRIMARY KEY	否	字段值默认为NULL
INT PRIMARY KEY AUTOINCREMENT	NULL	AUTOINCREMENT is only allowed on an INTEGER PRIMARY KEY，AUTOINCREMENT(创建失败，仅仅允许设置在INTEGER PRIMARY KEY的列上)
INTEGER PRIMARY KEY	是	自增（引擎没有创建sqlite_sequence表）。值 = 此表最大值 + 1，故可与之前删除的值重叠；当超过最大值时，会随机找一个没被使用的值
INTEGER PRIMARY KEY AUTOINCREMENT




 
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