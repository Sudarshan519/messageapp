// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StatusAdapter extends TypeAdapter<Status> {
  @override
  final typeId = 3;

  @override
  Status read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Status(
      name: fields[3] as String,
      id: fields[0] as String,
      imageURL: fields[1] as String,
      isSeen: fields[2] as bool,
      timeStamp: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Status obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.imageURL)
      ..writeByte(2)
      ..write(obj.isSeen)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.timeStamp);
  }
}
