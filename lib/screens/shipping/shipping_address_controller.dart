import 'dart:async';

import 'package:firebase_project/data/model/shipping_address_model.dart';
import 'package:firebase_project/data/repository/shipping_address_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final shippingAddressProvider =
    AsyncNotifierProvider.autoDispose<ShippingList, List<Address>>(() {
  return ShippingList();
});

class ShippingList extends AutoDisposeAsyncNotifier<List<Address>> {
  List<Address> shippingList = [];
  int currentPage = 1;
  int totalPage = 0;
  int limit = 25;

  @override
  FutureOr<List<Address>> build() {
    return getShippingAddress();
  }

  Future<List<Address>> getShippingAddress() async {
    try {
      final shipping = await ShippingAddressRepository.instance
          .getShippingAddress(currentPage: currentPage, limit: limit);

      shippingList.addAll(shipping!.address!);

      totalPage = shipping.totalPages!;

      currentPage++;

      return shippingList;
    } catch (e) {
      rethrow;
    }
  }

  Future createAddress({required Map<String, dynamic> addressData}) async {
    try {
      final create =
          await ShippingAddressRepository.instance.createShipping(addressData: {
        "name": addressData['name'].toString().trim(),
        "address": addressData['address'].toString().trim(),
        "city": addressData['city'].toString().trim(),
        "state": addressData['state'].toString().trim(),
        "pincode": addressData['pincode'].toString().trim(),
        "phone": addressData['phone'].toString().trim(),
        "country": addressData['country'].toString().trim(),
        "alt_phone": addressData['alt_phone'] == null
            ? addressData['alt_phone']
            : addressData['alt_phone'].toString().trim(),
      });

      shippingList.clear();
      currentPage = 1;

      return create;
    } catch (e) {
      rethrow;
    }
  }

  Future updateAddress({
    required Map<String, dynamic> addressData,
    required int shippingId,
  }) async {
    try {
      final update =
          await ShippingAddressRepository.instance.updateShipping(addressData: {
        "id": shippingId,
        "name": addressData['name'].toString().trim(),
        "address": addressData['address'].toString().trim(),
        "city": addressData['city'].toString().trim(),
        "state": addressData['state'].toString().trim(),
        "pincode": addressData['pincode'].toString().trim(),
        "phone": addressData['phone'].toString().trim(),
        "country": addressData['country'].toString().trim(),
        "alt_phone": addressData['alt_phone'] == null
            ? addressData['alt_phone']
            : addressData['alt_phone'].toString().trim(),
        "default_address": addressData['default_address'],
      });

      shippingList.clear();
      currentPage = 1;

      return update;
    } catch (e) {
      rethrow;
    }
  }

  Future deleteAddress({required int addressId}) async {
    try {
      final delete = await ShippingAddressRepository.instance
          .deleteAddress(addressId: addressId);

      shippingList.clear();
      currentPage = 1;

      return delete;
    } catch (e) {
      rethrow;
    }
  }
}

final shippingEditProvider =
    FutureProvider.autoDispose.family((ref, int addressId) async {
  try {
    return await ShippingAddressRepository.instance
        .editShipping(addressId: addressId);
  } catch (e) {
    rethrow;
  }
});
