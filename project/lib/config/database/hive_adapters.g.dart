// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] == null ? 1 : (fields[0] as num).toInt(),
      age: fields[1] == null ? 20 : (fields[1] as num).toInt(),
      name: fields[2] == null ? "" : fields[2] as String,
      username: fields[3] == null ? "example@email.com" : fields[3] as String,
      password: fields[4] == null ? "" : fields[4] as String,
      height: fields[5] == null ? 175.0 : (fields[5] as num).toDouble(),
      weight: fields[6] == null ? 60.0 : (fields[6] as num).toDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.age)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.username)
      ..writeByte(4)
      ..write(obj.password)
      ..writeByte(5)
      ..write(obj.height)
      ..writeByte(6)
      ..write(obj.weight);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
