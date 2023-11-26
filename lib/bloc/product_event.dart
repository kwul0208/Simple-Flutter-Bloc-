part of 'product_bloc.dart';

// @immutable
abstract class ProductEvent {}
class GetProductEvent extends ProductEvent{}


class ProductClicked extends ProductEvent {
  final ProductModel clickedProduct;

  ProductClicked({required this.clickedProduct});
}

class ProductRemove extends ProductEvent{
  final ProductModel clickedProductRemove;

  ProductRemove({required this.clickedProductRemove});
}