import 'package:equatable/equatable.dart';

class Cart extends Equatable {
  final String id;
  final String name;
  final double price;
  
  const Cart({
    required this.id,
    required this.name,
    required this.price,

  });
  const Cart.empty()
      : id = '',
        name = '',
        price = 0.0;

  Cart copyWith({
    String? id,
    String? name,
    double? price,
  }) {
    return Cart(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }
  
  @override
  List<Object?> get props =>[
    id,
    name,
    price,
  ];
  
}