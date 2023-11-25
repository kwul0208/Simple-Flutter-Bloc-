import 'package:bloc_training/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc()..add(GetProductEvent()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter BLoc"),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if(state is ProductLoading){
            return Center(child: CircularProgressIndicator());
          }
          if(state is ProductSuccess){
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .78,
                ),
                itemBuilder: (context, i) {
                  return Padding(
                    padding: EdgeInsets.all(4),
                    child: Container(
                      color: Colors.blue,
                      child: Column(
                        children: [
                          Text(state.products[i].title), 
                          Text(state.products[i].category.name), 
                          Text(state.products[i].price.toString())],
                      ),
                    ),
                  );
                });
          }
          if (state is ProductError) {
            return Center(child: Text(state.message),);
          }
          return Center(child: Text("Data not found"),);
        },
      ),
    );
  }
}
