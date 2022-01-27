class ThoughtModel {
  int id = 0;
  String createTime;
  String text;
  String? imagePathsStr;//","分隔

  ThoughtModel(
    this.createTime,
    this.text,
    this.imagePathsStr,
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'create_time': createTime,
      'text': text,
      'image_paths_str': imagePathsStr,
    };
  }
}
