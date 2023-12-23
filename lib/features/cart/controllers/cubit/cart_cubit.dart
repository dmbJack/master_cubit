import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:master_cubit/models/cart.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartEmpty());

  void addCard(Cart cart) async {
    emit(state.copyWith(status: CartStatus.loading));
    await Future.delayed(const Duration(seconds: 3));
    emit(
      AddedCard(
          cartItems: List.from(state.cartItems)..add(cart),
          status: CartStatus.success),
    );
  }

  void removeCard(Cart cart) async {
    emit(state.copyWith(status: CartStatus.loading));
    await Future.delayed(const Duration(seconds: 3));
    emit(
      RemovedCard(
          cartItems: List.from(state.cartItems)..remove(cart),
          status: CartStatus.success),
    );
  }

  void clearCart() {
    emit(CartEmpty());
  }
}
