import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_cubit/features/cart/controllers/cubit/cart_cubit.dart';
import 'package:master_cubit/models/cart.dart';
import 'package:uid/uid.dart';
import 'package:badges/badges.dart' as badges;

import 'cart_list.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Cart> productList = [
    Cart(id: UId.getId(), name: 'Item 1', price: 10.0),
    Cart(id: UId.getId(), name: 'Item 2', price: 20.0),
    Cart(id: UId.getId(), name: 'Item 3', price: 30.0),
    Cart(id: UId.getId(), name: 'Item 4', price: 40.0),
    Cart(id: UId.getId(), name: 'Item 5', price: 50.0),
    Cart(id: UId.getId(), name: 'Item 6', price: 60.0),
    Cart(id: UId.getId(), name: 'Item 7', price: 70.0),
    Cart(id: UId.getId(), name: 'Item 8', price: 80.0),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        actions: [
          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartList(),
                    ),
                  );
                },
                icon: badges.Badge(
                  badgeContent: Text(
                    state.cartItems.length.toString(),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  child: const Icon(Icons.shopping_basket_outlined),
                ),
              );
            },
          )
        ],
      ),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.status == CartStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.separated(
              itemBuilder: (context, index) {
                final product = productList[index];
                return ListTile(
                  title: Text(product.name),
                  trailing: BlocConsumer<CartCubit, CartState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return !state.cartItems.contains(product)
                          ? IconButton.filled(
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () {
                                context.read<CartCubit>().addCard(product);
                              },
                              icon: const Icon(Icons.add),
                            )
                          : IconButton.filled(
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () {
                                context.read<CartCubit>().removeCard(product);
                              },
                              icon: const Icon(Icons.remove));
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: productList.length);
        },
      ),
    );
  }
}
