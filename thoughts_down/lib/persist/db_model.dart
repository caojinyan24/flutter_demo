class ThoughtModel {
  int id = 0;
  String createTime;
  String text;

  ThoughtModel(
    this.createTime,
    this.text,
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'create_time': createTime,
      'text': text,
    };
  }
}
