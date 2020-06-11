// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CallsDetails.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CallDetailsAdapter extends TypeAdapter<CallDetails> {
  @override
  final typeId = 1;

  @override
  CallDetails read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CallDetails(
      name: fields[1] as String,
      id: fields[2] as String,
      imageURL: fields[3] as String,
      time: fields[4] as String,
      times: fields[5] as int,
      incomingTrue: fields[6] as bool,
      callTrue: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CallDetails obj) {
    writer
      ..writeByte(7)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.imageURL)
      ..writeByte(4)
      ..write(obj.time)
      ..writeByte(5)
      ..write(obj.times)
      ..writeByte(6)
      ..write(obj.incomingTrue)
      ..writeByte(7)
      ..write(obj.callTrue);
  }
}
