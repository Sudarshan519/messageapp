import 'package:hive/hive.dart';
part 'ChatUser.g.dart';

@HiveType(typeId: 0)
class ChatUser {
  @HiveField(0)
  String name;
  @HiveField(1)
  String imageURL;
  @HiveField(2)
  String message;
  @HiveField(3)
  String date;
  @HiveField(4)
  String time;
  @HiveField(5)
  bool seen;
  @HiveField(6)
  bool sent;
  @HiveField(7)
  int newMessages;
  @HiveField(8)
  String id;
  ChatUser(
      {this.name,
      this.imageURL,
      this.message,
      this.id,
      this.date,
      this.time,
      this.seen,
      this.sent,
      this.newMessages});
}

// List<ChatUser> dummyMsg = [
//   ChatUser(
//       name: "Seten McCarthy Elllipis",
//       imageURL:
//           'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRMgWEgB0qr0oq_h6ktSJ16KrmRCD0GfEvj6KRZINYk2hGAXjFF&usqp=CAU',
//       message:
//           "Hey did you have your yes yes yse yse syse yse yse yse shhhhhhhhhhhhhhh smartphonejjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjlllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll !",
//       date: "11/20/2020",
//       time: "17:30",
//       seen: true,
//       sent: false,
//       newMessages: 2),
//   ChatUser(
//       name: "Seten McCarthy ",
//       imageURL:
//           'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRMgWEgB0qr0oq_h6ktSJ16KrmRCD0GfEvj6KRZINYk2hGAXjFF&usqp=CAU',
//       message:
//           "Hey did you have your yes yes yse yse syse yse yse yse shhhhhhhhhhhhhhh smartphonejjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjlllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll !",
//       date: "11/20/2020",
//       time: "17:30",
//       seen: false,
//       sent: false,
//       newMessages: 2),
// ];
