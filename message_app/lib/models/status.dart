import 'package:hive/hive.dart';
part 'status.g.dart';

@HiveType(typeId: 3)

class Status extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String imageURL;
  @HiveField(2)
  bool isSeen;
  @HiveField(3)
  String name;
  @HiveField(4)
  int timeStamp;
  Status({this.name, this.id, this.imageURL, this.isSeen, this.timeStamp});
}
