// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Message.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageAdapter extends TypeAdapter<Message> {
  @override
  final typeId = 2;

  @override
  Message read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Message(
      isImage: fields[7] as bool,
      msg: fields[0] as String,
      timeStamp: fields[2] as int,
      seen: fields[3] as bool,
      received: fields[4] as bool,
      sent: fields[5] as bool,
      isMe: fields[6] as bool,
      id: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Message obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.msg)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.timeStamp)
      ..writeByte(3)
      ..write(obj.seen)
      ..writeByte(4)
      ..write(obj.received)
      ..writeByte(5)
      ..write(obj.sent)
      ..writeByte(6)
      ..write(obj.isMe)
      ..writeByte(7)
      ..write(obj.isImage);
  }
}
