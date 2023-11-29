import 'package:bloc_training/UI/Dashboard.dart';
import 'package:bloc_training/bloc/auth/auth_bloc_bloc.dart';
import 'package:bloc_training/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late final AuthBlocBloc authBlocBloc;

  @override
  void initState(){
    authBlocBloc = BlocProvider.of<AuthBlocBloc>(context, listen: false);
    print("welcome");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: BlocConsumer<AuthBlocBloc, AuthBlocState>(
        bloc: authBlocBloc,
        listener: (context, state) async {
          if(state is UserLoginSuccessState){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyApp(isLoggedIn: true)), (route) => false);
          }else if(state is LoginErrorState){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.msg}'),
              ),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(labelText: 'Email'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(labelText: 'Password'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Perform login logic here
                            String email = _emailController.text;
                            String password = _passwordController.text;
                            // Add your authentication logic heres
                            authBlocBloc.add(LoginButtonPress(email: email, pass: password));
                          }
                        },
                        child: Text('Login'),
                      ),
                    ],
                  ),
                ),
              ),
              Builder(
                builder: (context) {
                  if (state is LoginLoadingState) {
                    return Container(
                      color: Color.fromARGB(66, 0, 0, 0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return SizedBox();
                }
              )
            ],
          );
        },
      ),
    );
  }
}
