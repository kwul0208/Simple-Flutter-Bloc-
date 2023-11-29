
import 'package:bloc/bloc.dart';
import 'package:bloc_training/repository/auth/authRepo.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  var repo = AuthRepository();
  AuthBlocBloc(AuthBlocState initialState, this.repo) : super(initialState){
    on<StartAuthEvent>((event, state)async{
      emit(LoginInitState());
    });
    on<LoginButtonPress>((event, emit)async{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      print("==== auth ====");
      emit(LoginLoadingState());
      var data = await repo.login(event.email, event.pass);
      print("bloc");
      print(data['data']['access_token']);
      if(data['status'] == true){
        await prefs.setString("access_token", data['data']['access_token']);
        await prefs.setString("refresh_token", data['data']['refresh_token']);
        emit(UserLoginSuccessState());
      }else{
        emit(LoginErrorState(msg: data['message']));
      }
    });
  }
    // @override
    // Stream<AuthBlocState> mapEventToState(AuthBlocEvent event)async*{
    //   var pref = await SharedPreferences.getInstance();
    //   if(event is StartAuthEvent){
    //     yield LoginInitState();
    //   }else if(event is LoginButtonPress){
    //     print("==== auth ====");
    //     yield LoginLoadingState();
    //     var data = repo.login(event.email, event.pass);
    //     if(data['status'] == true){
    //       pref.setString("access_token", data['data']['access_token']);
    //       pref.setString("access_token", data['data']['refresh_token']);
    //       yield UserLoginSuccessState();
    //     }else{
    //       yield LoginErrorState(msg: data['message']);
    //     }
    //   }
    // }
  
}
