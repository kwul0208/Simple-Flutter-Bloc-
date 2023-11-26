import 'package:bloc_training/UI/detail/Result.dart';
import 'package:bloc_training/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final ProductBloc _productBloc;

  @override
  void initState() {
    _productBloc = BlocProvider.of<ProductBloc>(context);
    _productBloc.add(GetProductEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("mainBuild");
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter BLoc"),
      ),
      body: Column(
        children: [
          Result(),
          Text("data"),
          BlocBuilder<ProductBloc, ProductState>(
            bloc: _productBloc,
            builder: (context, state) {
              if (state is ProductLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is ProductSuccess) {
                print("rebuild1");
                return Expanded(
                  child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: .58,
                      ),
                      itemCount: state.products.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: EdgeInsets.all(4),
                          child: Container(
                            color: Colors.blue,
                            child: Column(
                              children: [
                                ClipRRect(
                                  child: Image.network(
                                    state.products[i].images[0],
                                    scale: 4,
                                  ),
                                ),
                                Text(state.products[i].title),
                                Text(state.products[i].category.name),
                                Text(state.products[i].price.toString()),
                                Text("Total : ${state.productsLength}"),
                                Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: (){
                                        context.read<ProductBloc>().add(ProductRemove(clickedProductRemove: state.products[i]));
                                      }, 
                                      child: Text("min")
                                    ),
                                    ElevatedButton(
                                      onPressed: (){
                                        context.read<ProductBloc>().add(ProductClicked(clickedProduct:state.products[i]));
                                      }, 
                                      child: Text("plus")
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                );
              }
              if (state is ProductError) {
                return Center(
                  child: Text(state.message),
                );
              }
              return Center(
                child: Text("Data not found ${state}"),
              );
            },
          ),
        ],
      ),
    );
  }
}