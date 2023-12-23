part of 'cart_cubit.dart';

enum CartStatus {
  initial,
  loading,
  success,
  failure,
}

class CartState extends Equatable {
  final List<Cart> cartItems;
  final CartStatus status;
  const CartState({
    this.cartItems = const [],
    this.status = CartStatus.initial,
  });

  CartState copyWith({
    List<Cart>? cartItems,
    CartStatus? status,
  }) {
    return CartState(
      cartItems: cartItems ?? this.cartItems,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [cartItems];
}

final class CartEmpty extends CartState {}

class AddedCard extends CartState {
  const AddedCard({required super.cartItems, required super.status});
}

class RemovedCard extends CartState {
  const RemovedCard({required super.cartItems, required super.status});
}


