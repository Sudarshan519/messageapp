import 'package:hive/hive.dart';
part 'CallsDetails.g.dart';
@HiveType(typeId: 1)
class CallDetails {
  @HiveField(1)
  String name;
  @HiveField(2)
  String id;
  @HiveField(3)
  String imageURL;
  @HiveField(4)
  String time;
  @HiveField(5)
  int times;
  @HiveField(6)
  bool incomingTrue;
  @HiveField(7)
  bool callTrue;
  CallDetails(
      {this.name,
      this.id,
      this.imageURL,
      this.time,
      this.times,
      this.incomingTrue,
      this.callTrue});
}

List<CallDetails> listOfCalls = [
  CallDetails(
      name: "sid test",
      imageURL: 'assets/images/person1.jpeg',
      time: '10 March, 12:26 pm',
      times: 3,
      incomingTrue: true,
      callTrue: false),
];
