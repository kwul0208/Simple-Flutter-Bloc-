import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../models/Product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<GetProductEvent>((event, emit) async {
      emit(ProductLoading());
      final response = await http.get(Uri.parse("https://api.escuelajs.co/api/v1/products?offset=0&limit=10"));
      // print(response.body);
      print(response.statusCode == 200);
      switch (response.statusCode) {
        case 200:
        print("===remit");
          emit(ProductSuccess(products: ProductModelFromJson(response.body), productsLength: ProductModelFromJson(response.body).length, productTotal: ProductModelFromJson(response.body).length));
          break;
        case 404:
          emit(ProductError(message: "Kesalahan Data"));
          break;
        case 500:
          emit(ProductError(message: "Internal Server Error"));
          break;
        default:
      }
    });
    on<ProductRemove>((event, emit){
      final currentState = state;
      if(currentState is ProductSuccess){
        final List<ProductModel> updateProduct = List.from(currentState.products)..remove(event.clickedProductRemove);
        emit(ProductSuccess(products: updateProduct, productsLength: updateProduct.length, productTotal: updateProduct.length));
      }
    });
    // on<RemoveProduct>((event, emit) {
    //   // if (state is CartLoaded) {
    //     final state = this.state;
    //     print("state");
    //     print(state);
    //     print("event.product");
    //     print(jsonEncode(event.product));
    //     // emit(ProductSuccess(products: List.from(state.products)..remove(event.product)));
    //     // final state = this.state as CartLoaded;
    //     // emit(CartLoaded(
    //     //     cart: Cart(
    //     //         products: List.from(state.cart.products)
    //     //           ..remove(event.product))));
    //   // }
    // });
    on<ProductClicked>((event, emit) {
      // Lakukan sesuatu dengan produk yang diklik
      // Misalnya, tambahkan produk ke dalam daftar produk
      final currentState = state;
      if (currentState is ProductSuccess) {
        final List<ProductModel> updatedProducts = List.from(currentState.products)
          ..add(event.clickedProduct);
        emit(ProductSuccess(products: updatedProducts, productsLength: updatedProducts.length, productTotal: currentState.productTotal));
      }
    });
  }

void test() {
  final currentState = state;
  if (currentState is ProductSuccess) {
    final List<ProductModel> products = currentState.products;
    // Lakukan sesuatu dengan daftar produk
    print(jsonEncode(products));
  }
  }
}
