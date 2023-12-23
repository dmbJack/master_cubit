import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_cubit/features/cart/controllers/cubit/cart_cubit.dart';
import 'package:master_cubit/models/cart.dart';

class CartList extends StatefulWidget {
  const CartList({super.key});

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart List'),
      ),
      body: SafeArea(
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state.cartItems.isEmpty) {
              return const Center(
                child: Text('Votre panier est vide'),
              );
            }
            if (state.status == CartStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.separated(
                itemBuilder: (context, index) {
                  final product = state.cartItems[index];
                  return ListTile(
                      title: Text(product.name),
                      trailing: IconButton(
                        onPressed: () {
                          context.read<CartCubit>().removeCard(product);
                        },
                        icon: const Icon(Icons.delete_forever),
                      ));
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: state.cartItems.length);
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              context.read<CartCubit>().clearCart();
            },
            child: const Text(
              "Vider mon panier",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )),
      ),
    );
  }
}
