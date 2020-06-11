import 'package:hive/hive.dart';
part 'Message.g.dart';

@HiveType(typeId: 2)
class Message {
  @HiveField(0)
  String msg;
  @HiveField(1)
  String id;
  @HiveField(2)
  int timeStamp;
  @HiveField(3)
  bool seen;
  @HiveField(4)
  bool received;
  @HiveField(5)
  bool sent;
  @HiveField(6)
  bool isMe;
  @HiveField(7)
  bool isImage;
  Message(
      {this.isImage,
      this.msg,
      this.timeStamp,
      this.seen,
      this.received,
      this.sent,
      this.isMe,
      this.id});
}

List<Message> msgs = [];
