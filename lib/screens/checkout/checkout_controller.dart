import 'package:firebase_project/data/model/checkout_model.dart';
import 'package:firebase_project/data/model/shipping_address_model.dart';
import 'package:firebase_project/data/repository/checkout_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final checkoutProvider = FutureProvider.autoDispose((ref) async {
  try {
    final shippingAddress = await CheckoutRepository.instance.getCheckout();

    ref
        .read(checkoutShippingAddressProvider.notifier)
        .update((state) => shippingAddress!.address![0]);

    print(ref.read(checkoutShippingAddressProvider));

    return shippingAddress;
  } catch (e) {
    rethrow;
  }
});

final checkoutShippingAddressProvider = StateProvider((ref) {
  return Address();
});

final paymentTypeProvider = StateProvider.autoDispose((ref) {
  return "";
});

final placeOrderCODProvider =
    FutureProvider.autoDispose.family((ref, CheckoutModel checkout) async {
  try {
    List lst = [];

    for (int i = 0; i < checkout.carts!.length; i++) {
      lst.add({
        "product_id": checkout.carts![i].productId,
        "price": checkout.carts![i].price,
        "quantity": checkout.carts![i].quantity,
      });
    }

    return await CheckoutRepository.instance.placeOrderCOD(codData: {
      "address_id": ref.read(checkoutShippingAddressProvider).id,
      "cart_items": lst,
      "total_amount": checkout.orderSummary!.totalAmount,
      "payment_type": ref.read(paymentTypeProvider),
      "txn_id": ""
    });
  } catch (e) {
    rethrow;
  }
});
