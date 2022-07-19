class NotesImpName {
  static const String id = "id";
  static const String title = "title";
  static const String uniqueId = "uniqueId";
  static const String content = "content";
  static const String pin = "pin";
  static const String createTime = "createTime";
  static const String isArchive = "isArchive";
  static const String tableName = "Notes";

  static final List values = [
    id,
    title,
    content,
    pin,
    createTime,
    isArchive,
  ];
}

class Notes {
  final int? id;
  final String title;
  final String uniqueId;
  final String content;
  final bool pin;
  final bool isArchive;
  final DateTime createTime;
  Notes(
      {this.id,
      required this.title,
      required this.uniqueId,
      required this.content,
      required this.pin,
      required this.isArchive,
      required this.createTime});

  Notes copy(
      {final int? id,
      final String? uniqueId,
      final String? title,
      final String? content,
      final bool? pin,
      final bool? isArchive,
      final DateTime? createTime}) {
    return Notes(
      id: id ?? this.id,
      title: title ?? this.title,
      uniqueId: uniqueId ?? this.uniqueId,
      content: content ?? this.content,
      pin: pin ?? this.pin,
      isArchive: isArchive ?? this.isArchive,
      createTime: createTime ?? this.createTime,
    );
  }

  static Notes fromJson(Map<String, Object?> json) {
    return Notes(
        id: json[NotesImpName.id] as int?,
        title: json[NotesImpName.title] as String,
        uniqueId: json[NotesImpName.uniqueId] as String,
        content: json[NotesImpName.content] as String,
        pin: json[NotesImpName.pin] == 1,
        isArchive: json[NotesImpName.isArchive] == 1,
        createTime: DateTime.parse(json[NotesImpName.createTime] as String));
  }

  Map<String, Object?> toJson() {
    return {
      NotesImpName.id: id,
      NotesImpName.title: title,
      NotesImpName.uniqueId: uniqueId,
      NotesImpName.content: content,
      NotesImpName.pin: pin ? 1 : 0,
      NotesImpName.isArchive: isArchive ? 1 : 0,
      NotesImpName.createTime: createTime.toIso8601String(),
    };
  }
}
