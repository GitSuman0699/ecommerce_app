import 'dart:async';

import 'package:firebase_project/data/model/cart_model.dart';
import 'package:firebase_project/data/model/product_detail_model.dart';
import 'package:firebase_project/data/repository/cart_repository.dart';
import 'package:firebase_project/utils/constants/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  Future addCart({required Product product}) async {
    try {
      final addToCart = CartRepository.instance.addCart(cartData: {
        "product_id": product.id,
        "quantity": 1,
        "price": product.price,
        "stock": product.stock,
        "attributes": ref.read(attributeDataProvider)
      });

      return addToCart;
    } catch (e) {
      rethrow;
    }
  }

  Future addQuantity(
      {required Carts cart, required BuildContext context}) async {
    try {
      if (cart.quantity! <= cart.stock!) {
        final addQuantity = await CartRepository.instance.updateQuantity(
            data: {"id": cart.id, "quantity": cart.quantity! + 1});

        return addQuantity;
      } else {
        // showCupertinoSnackBar(context: context, message: "Out of Stock");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            dismissDirection: DismissDirection.up,
            content: Text("Out of Stock")));
      }
    } catch (e) {
      rethrow;
    }
  }

  Future removeQuantity(
      {required Carts cart, required BuildContext context}) async {
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

  Future deleteCartItem(
      {required int cartId, required BuildContext context}) async {
    try {
      final deleteItem =
          await CartRepository.instance.deleteCartItem(data: {"id": cartId});

      return deleteItem;
    } catch (e) {
      rethrow;
    }
  }
}

final attributeDataProvider = StateProvider((ref) {
  return [];
});
