import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../models/Product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      emit(ProductLoading());
      final response = await http.get(Uri.parse("https://api.escuelajs.co/api/v1/products1"));
      print(response.statusCode == 200);
      switch (response.statusCode) {
        case 200:
          emit(ProductSuccess(products: ProductModelFromJson(response.body)));
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
  }
}
