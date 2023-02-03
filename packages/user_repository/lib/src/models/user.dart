import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(this.id, this.firstName);

  final String id;
  final String firstName;

  @override
  List<Object> get props => [id, firstName];

  static const empty = User('-', 'David');
}
