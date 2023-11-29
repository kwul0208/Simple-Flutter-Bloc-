part of 'auth_bloc_bloc.dart';

abstract class AuthBlocEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StartAuthEvent extends AuthBlocEvent{}

class LoginButtonPress extends AuthBlocEvent{
  final String email;
  final String pass;
  LoginButtonPress({required this.email, required this.pass});
}




