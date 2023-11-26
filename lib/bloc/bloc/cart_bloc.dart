
import 'package:bloc_training/models/CartModel.dart';
import 'package:bloc_training/models/Product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial(cartItem: [])) {
    on<CartEvent>((event, emit) {
      // TODO: implement event handler
    });
      on<AddProduct>((event, emit){
      _cartItems.add(event.productIndex);
       emit(ProductAdded(cartItem: _cartItems));
    });
  }
  final List<int> _cartItems = [];
  List<int> get items => _cartItems;
}
