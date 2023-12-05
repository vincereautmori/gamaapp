// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfileHiveAdapter extends TypeAdapter<ProfileHive> {
  @override
  final int typeId = 0;

  @override
  ProfileHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProfileHive(
      email: fields[0] as String,
      username: fields[1] as String,
      fullname: fields[2] as String,
      role: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProfileHive obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.fullname)
      ..writeByte(3)
      ..write(obj.role);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
