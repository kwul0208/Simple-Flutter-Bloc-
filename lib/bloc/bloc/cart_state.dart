part of 'cart_bloc.dart';

// @immutable
abstract class CartState {
  final List<int> cartItem;
  const CartState({required this.cartItem});

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {
  CartInitial({required List<int> cartItem}) : super(cartItem: cartItem);
}

class ProductAdded extends CartState {
  final List<int> cartItem;

   ProductAdded({required this.cartItem}) : super(cartItem: cartItem);

  @override
  List<Object> get props => [cartItem];

  @override
  String toString() => 'ProductAdded { todos: $cartItem }';
}
