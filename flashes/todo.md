# 2022-01-27
```CocoaPods not installed or not in valid state```
重试了CocoaPods卸载安装，Androidstudio卸载安装不管用
到ios文件夹下，执行：`pod install`，根据提示信息做处理
# 2022-01-26
数据表增加一列？？？
step by step:如何初始化一个项目
uploadimage and display image
# 2022-01-25
问号
一个问号，表示可以为空。整体表示声明一个类型（int? a）
两个问号,表示，如果左边为空，则等于右边的值。整体表示一个value值（a??5）
# 2022-01-20
1. 日志增加
2. 输入框富文本
3. 图片上传---image_pickers：https://pub.dev/packages/image_pickers

编辑页面
1. 上传照片（不实际存储，使用照片的引用路径+照片名字）
2. 编辑框使用富文本，支持上传图片

version 相关介绍：https://dart.dev/tools/pub/dependencies#version-constraints
??命名：什么时候下划线？
# 2022-01-19
文件保存（使用json or 所见即所得），暂时所见即所得，只做备份使用
# 2022-01-18
column 列溢出的处理（ListView）
格式的调整（目前都是居中处理的？？？）（ListTitle）

# 2022-01-17
FutureBuilder
# 2022-01-05
todo: 编辑框的鼠标自动对焦
Divider()---列表中各个选项间的分割线
# 2022-01-04
TODO : 修改日志打印https://dart.dev/guides/language/analysis-options#enabling-linter-rules
屏幕滚动
issue:异步加载数据，导致初始启动时页面空白无列表(暂时做deley启动，启动前做数据预加载)
TODO：页面滚动，列表倒序排列，数据分页分批从数据库读取

done：完成数据持久化读取
# 2021-12-31
await关键字？？
dart void 修饰符
sqflite自增ID：

INT PRIMARY KEY	否	字段值默认为NULL
INT PRIMARY KEY AUTOINCREMENT	NULL	AUTOINCREMENT is only allowed on an INTEGER PRIMARY KEY，AUTOINCREMENT(创建失败，仅仅允许设置在INTEGER PRIMARY KEY的列上)
INTEGER PRIMARY KEY	是	自增（引擎没有创建sqlite_sequence表）。值 = 此表最大值 + 1，故可与之前删除的值重叠；当超过最大值时，会随机找一个没被使用的值
INTEGER PRIMARY KEY AUTOINCREMENT

获取Future的内容
异步读取调用
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