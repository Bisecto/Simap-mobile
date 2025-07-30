import '../../model/store_model/store.dart';

abstract class StoreState {}

class StoreInitial extends StoreState {}

class StoreLoading extends StoreState {}

class StoreLoaded extends StoreState {
  final List<Product> products;
  final String pageName;
  final bool hasNext;
  final bool hasPrevious;

  StoreLoaded({
    required this.products,
    required this.pageName,
    required this.hasNext,
    required this.hasPrevious,
  });
}

class StoreError extends StoreState {
  final String message;
  StoreError(this.message);
}

class ProductAddedToCart extends StoreState {
  final Product product;
  ProductAddedToCart(this.product);
}
