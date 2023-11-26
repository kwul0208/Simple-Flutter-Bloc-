import 'package:bloc_training/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Result extends StatelessWidget {
  const Result({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<ProductBloc, ProductState>(
    //   bloc: BlocProvider.of<ProductBloc>(context),
    //   builder: (context, state) {
    //     if (state is ProductSuccess) {
    //       print("rebuilr2");
    //       return Text("${state.productsLength}");
    //     }
    //     return SizedBox();
    //   }
    // );
    return Column(
      children: [
        BlocSelector<ProductBloc, ProductState, int>(
          selector: (state) {
            print(state is ProductSuccess);
            if (state is ProductSuccess) {
              return state.productsLength;
            }
            return 0; // Kembalikan nilai default jika state bukan ProductSuccess
          },
          builder: (context, productsLength) {
            print("rebuild");
            return Text("$productsLength");
          },
        ),
        BlocSelector<ProductBloc, ProductState, int>(
          // bloc: BlocProvider.of<ProductBloc>(context),
          selector: (state){
            print(state is ProductSuccess);
            if (state is ProductSuccess) {
              return state.productTotal;
            }
            return 0;
          },
          builder: (context, state) {
            
              print("rebuilBuilder");
              return Text("ee ${state}");
         
          }
        )
      ],
    );
  }
}