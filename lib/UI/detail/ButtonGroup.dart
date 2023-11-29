import 'package:flutter/material.dart';

class ButtonGrup extends StatelessWidget {
  const ButtonGrup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
            onPressed: () {
              // context.read<ProductBloc>().add(
              //     ProductRemove(
              //         clickedProductRemove:
              //             state.products[i]));
              
            },
            child: Text("min")),
        ElevatedButton(
            onPressed: () {
              // context.read<ProductBloc>().add(
              //     ProductClicked(
              //         clickedProduct:
              //             state.products[i]));
            },
            child: Text("plus"))
      ],
    );
  }
}