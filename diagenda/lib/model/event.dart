import 'package:diagenda/enumerations.dart';
//import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';

class Event extends Equatable {
  int? key;

  String title;

  ImportanceLevel importanceLevel;

  bool notification;

  Event(
      {this.title = "Title",
      this.key,
      this.importanceLevel = ImportanceLevel.Low,
      required this.notification});

  // @override
  // int get hashCode => super.hashCode;

  // @override
  // String toString() => key.toString();

  @override
  // TODO: implement props
  List<Object?> get props => [key, title, importanceLevel, notification];
}
