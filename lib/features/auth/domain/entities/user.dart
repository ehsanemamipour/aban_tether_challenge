import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  final int id;
  final String name;
  final String email;
  final String? phoneNumber;

  @override
  List<Object?> get props => [id];
}
