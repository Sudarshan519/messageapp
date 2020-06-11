// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChatUser.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatUserAdapter extends TypeAdapter<ChatUser> {
  @override
  final typeId = 0;

  @override
  ChatUser read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatUser(
      name: fields[0] as String,
      imageURL: fields[1] as String,
      message: fields[2] as String,
      id: fields[8] as String,
      date: fields[3] as String,
      time: fields[4] as String,
      seen: fields[5] as bool,
      sent: fields[6] as bool,
      newMessages: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ChatUser obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.imageURL)
      ..writeByte(2)
      ..write(obj.message)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.time)
      ..writeByte(5)
      ..write(obj.seen)
      ..writeByte(6)
      ..write(obj.sent)
      ..writeByte(7)
      ..write(obj.newMessages)
      ..writeByte(8)
      ..write(obj.id);
  }
}
