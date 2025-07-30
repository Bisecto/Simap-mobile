import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simap/bloc/store_bloc/store_event.dart';
import 'package:simap/bloc/store_bloc/store_state.dart';

import '../../app_repository/store_service.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final StoreService storeService;

  StoreBloc({required this.storeService}) : super(StoreInitial()) {
    on<LoadHomeProducts>(_onLoadHomeProducts);
    on<LoadRecommendedProducts>(_onLoadRecommendedProducts);
    on<LoadAllProducts>(_onLoadAllProducts);
    on<LoadNewProducts>(_onLoadNewProducts);
    on<AddToCart>(_onAddToCart);
  }

  Future<void> _onLoadHomeProducts(
      LoadHomeProducts event,
      Emitter<StoreState> emit,
      ) async {
    emit(StoreLoading());
    try {
      final response = await storeService.getHomeProducts();
      emit(StoreLoaded(
        products: response.pageObj.objectList,
        pageName: response.pageName,
        hasNext: response.pageObj.hasNext,
        hasPrevious: response.pageObj.hasPrevious,
      ));
    } catch (e) {
      emit(StoreError(e.toString()));
    }
  }

  Future<void> _onLoadRecommendedProducts(
      LoadRecommendedProducts event,
      Emitter<StoreState> emit,
      ) async {
    emit(StoreLoading());
    try {
      final response = await storeService.getRecommendedProducts();
      emit(StoreLoaded(
        products: response.pageObj.objectList,
        pageName: response.pageName,
        hasNext: response.pageObj.hasNext,
        hasPrevious: response.pageObj.hasPrevious,
      ));
    } catch (e) {
      emit(StoreError(e.toString()));
    }
  }

  Future<void> _onLoadAllProducts(
      LoadAllProducts event,
      Emitter<StoreState> emit,
      ) async {
    // For now, load home products. You can implement separate endpoint later
    add(LoadHomeProducts());
  }

  Future<void> _onLoadNewProducts(
      LoadNewProducts event,
      Emitter<StoreState> emit,
      ) async {
    // For now, load home products. You can implement separate endpoint later
    add(LoadHomeProducts());
  }

  Future<void> _onAddToCart(
      AddToCart event,
      Emitter<StoreState> emit,
      ) async {
    // Implement add to cart logic here
    // For now, just emit success state
    emit(ProductAddedToCart(event.product));
  }
}