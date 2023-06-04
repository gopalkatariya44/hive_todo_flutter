class Todo {
  final String? id;
  int? key;
  final String? title;
  final bool? isEnable;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Todo({
    this.id,
    this.key,
    this.title,
    this.isEnable,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (key != null) {
      result.addAll({'key': key});
    }
    if (title != null) {
      result.addAll({'title': title});
    }
    if (isEnable != null) {
      result.addAll({'is_enable': isEnable});
    }
    if (createdAt != null) {
      result.addAll({'created_at': createdAt});
    }
    if (updatedAt != null) {
      result.addAll({'updated_at': updatedAt});
    }

    return result;
  }

  factory Todo.fromJson(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      key: map['key'],
      title: map['title'],
      isEnable: map['is_enable'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }

  set setKey(int todoKey) {
    key = todoKey;
  }
}
