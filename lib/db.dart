import 'package:hive/hive.dart';

part 'db.g.dart';

@HiveType(typeId: 2)
class Note {
  Note({required this.title, required this.content});
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String content;
}
