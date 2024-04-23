import 'dart:async';

import 'package:firebase_project/data/model/cart_model.dart';
import 'package:firebase_project/data/repository/cart_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final cartProvider2 =
//     StateNotifierProvider.autoDispose<Cart, AsyncValue<CartModel>>(
//         name: 'cart_provider', (ref) {
//   return Cart(); //init empty cart
// });

// class Cart extends StateNotifier<AsyncValue<CartModel>> {
//   Cart() : super(const AsyncValue<CartModel>.loading()) {
//     getCart();
//   }

//   Future<CartModel?> getCart() async {
//     try {
//       final cart = await CartRepository.instance.getCart();
//       state = AsyncValue<CartModel>.data(cart!);
//     } catch (e) {
//       rethrow;
//     }
//     return null;
//   }

//   Future addQuantity(
//       {required Carts cart, required BuildContext context}) async {
//     try {
//       if (cart.quantity! <= cart.stock!) {
//         final addQuantity = await CartRepository.instance
//             .addQuantity(data: {"id": cart.id, "quantity": cart.quantity! + 1});

//         if (addQuantity['status'] == 200) {
//           getCart();
//         } else {
//           ScaffoldMessenger.of(context)
//               .showSnackBar(SnackBar(content: Text(addQuantity['message'])));
//         }
//       } else {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text("Out of Stock")));
//       }
//       return cart;
//     } catch (e) {
//       rethrow;
//     }
//   }
// }

final cartProvider = AsyncNotifierProvider.autoDispose<CartData, CartModel>(() {
  return CartData();
});

class CartData extends AutoDisposeAsyncNotifier<CartModel> {
  @override
  FutureOr<CartModel> build() {
    return getCart();
  }

  Future<CartModel> getCart() async {
    try {
      final cart = await CartRepository.instance.getCart();
      return cart!;
    } catch (e) {
      rethrow;
    }
  }

  addQuantity({required Carts cart, required BuildContext context}) async {
    try {
      if (cart.quantity! <= cart.stock!) {
        final addQuantity = await CartRepository.instance.updateQuantity(
            data: {"id": cart.id, "quantity": cart.quantity! + 1});

        return addQuantity;
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Out of Stock")));
      }
    } catch (e) {
      rethrow;
    }
  }

  removeQuantity({required Carts cart, required BuildContext context}) async {
    try {
      if (cart.quantity! > 1) {
        final removeQuantity = await CartRepository.instance.updateQuantity(
            data: {"id": cart.id, "quantity": cart.quantity! - 1});

        return removeQuantity;
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("1 Quantity is required")));
      }
    } catch (e) {
      rethrow;
    }
  }

  deleteCartItem({required int cartId, required BuildContext context}) async {
    try {
      final deleteItem =
          await CartRepository.instance.deleteCartItem(data: {"id": cartId});

      return deleteItem;
    } catch (e) {
      rethrow;
    }
  }
}
