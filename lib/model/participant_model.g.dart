// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participant_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ParticipantModelAdapter extends TypeAdapter<ParticipantModel> {
  @override
  final int typeId = 2;

  @override
  ParticipantModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ParticipantModel(
      groupName: fields[1] as String,
      participantName: fields[2] as String,
    )
      ..id = fields[0] as int?
      ..amount = fields[3] as int;
  }

  @override
  void write(BinaryWriter writer, ParticipantModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.groupName)
      ..writeByte(2)
      ..write(obj.participantName)
      ..writeByte(3)
      ..write(obj.amount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParticipantModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
