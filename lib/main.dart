import 'package:bloc_training/UI/Dashboard.dart';
import 'package:bloc_training/UI/auth/LoginPage.dart';
import 'package:bloc_training/bloc/auth/auth_bloc_bloc.dart';
import 'package:bloc_training/bloc/product_bloc.dart';
import 'package:bloc_training/repository/auth/authRepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('access_token');

  runApp(MyApp(isLoggedIn: token != null));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<ProductBloc>(
            create: (context) => ProductBloc(),
          ),
          BlocProvider<AuthBlocBloc>(
            create: (context) => AuthBlocBloc(LoginInitState(), AuthRepository())
          )
        ],
        child: isLoggedIn ? Dashboard(title: "Dashboard",) : LoginPage(),
      ),

    );
  }
}

