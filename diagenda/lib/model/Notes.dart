import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

part 'Notes.g.dart';

@HiveType(typeId: 0)
class Notes extends HiveObject with EquatableMixin {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  DateTime timestamp;

  @HiveField(3)
  List<String> attachments;

  Notes(
      {required this.title,
      required this.description,
      required this.timestamp,
      required this.attachments});

  @override
  // TODO: implement props
  List<Object?> get props => [title, description, timestamp, attachments, key];
}
