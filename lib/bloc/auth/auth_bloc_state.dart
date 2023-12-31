part of 'auth_bloc_bloc.dart';

abstract class AuthBlocState extends Equatable {
  const AuthBlocState();
  
  @override
  List<Object> get props => [];
}

class LoginInitState extends AuthBlocState{}

class LoginLoadingState extends AuthBlocState{}

class UserLoginSuccessState extends AuthBlocState{}

class LoginErrorState extends AuthBlocState{
  late String msg;
  LoginErrorState({required this.msg});
}

class LoginCheckState extends AuthBlocState{
  late String msg;
  LoginCheckState({required this.msg});
}

class Authenticated extends AuthBlocState{}
class UnAuthenticated extends AuthBlocState{}
