// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'via.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ViaAdapter extends TypeAdapter<Via> {
  @override
  final int typeId = 1;

  @override
  Via read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Via(
      name: fields[0] as String,
      autor: fields[1] as String,
      dificultad: fields[2] as int,
      comentario: fields[3] as String,
      presas: (fields[4] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Via obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.autor)
      ..writeByte(2)
      ..write(obj.dificultad)
      ..writeByte(3)
      ..write(obj.comentario)
      ..writeByte(4)
      ..write(obj.presas);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ViaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
