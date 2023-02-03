import 'package:equatable/equatable.dart';

class ActivityItem extends Equatable {
  ActivityItem(this.id, this.title, this.description, this.start,
      this.isRegister, this.numberAttendees);
  final int id;
  final String title;
  final String description;
  final DateTime start;
  bool isRegister;
  final int numberAttendees;

  @override
  List<Object> get props =>
      [id, title, description, start, isRegister, numberAttendees];
}
