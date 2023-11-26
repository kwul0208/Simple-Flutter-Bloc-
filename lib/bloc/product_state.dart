part of 'product_bloc.dart';


// @immutable
abstract class ProductState extends Equatable{
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductSuccess extends ProductState {
  final List<ProductModel> products;
  late int productsLength = 0;
  ProductSuccess({required this.products, required this.productsLength});

  @override
  List<Object> get props => [products];
}

class ProductError extends ProductState{
  final String message;
  ProductError({required this.message});
}
