import 'package:bloc_training/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Result extends StatelessWidget {
  const Result({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      bloc: BlocProvider.of<ProductBloc>(context),
      builder: (context, state) {
        if (state is ProductSuccess) {
          return Text("${state.productsLength}");
        }
        return SizedBox();
      }
    );
  }
}