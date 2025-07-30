import '../../model/store_model/store.dart';

abstract class StoreEvent {}

class LoadHomeProducts extends StoreEvent {}

class LoadRecommendedProducts extends StoreEvent {}

class LoadAllProducts extends StoreEvent {}

class LoadNewProducts extends StoreEvent {}

class AddToCart extends StoreEvent {
  final Product product;
  AddToCart(this.product);
}