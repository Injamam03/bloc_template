import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object?> get props => [];
}

class SignupSubmitted extends SignupEvent {
  final String name;
  final String email;
  final String password;
  final String countryName;


  const SignupSubmitted({
    required this.name,
    required this.email,
    required this.password,
    required this.countryName,
  });

  @override
  List<Object?> get props => [name, email, password, countryName];
}