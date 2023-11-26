part of 'cart_bloc.dart';

// @immutable
abstract class CartEvent {}

// class AddCartEvent extends CartEvent{
//   final ProductModel product;
//   AddCartEvent({required this.product}); 
//    @override
//   List<Object> get props => [product];
// }

class AddProduct extends CartEvent {
  final int productIndex;

  AddProduct(this.productIndex);

  @override
  List<Object> get props => [productIndex];

  @override
  String toString() => 'AddProduct { index: $productIndex }';
}



