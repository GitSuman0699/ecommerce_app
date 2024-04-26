import 'package:firebase_project/data/model/shipping_address_edit_model.dart';
import 'package:firebase_project/data/model/shipping_address_model.dart';
import 'package:firebase_project/data/repository/base_repository.dart';

class ShippingAddressRepository extends BaseRepository {
  ShippingAddressRepository._();
  static final instance = ShippingAddressRepository._();

  Future<ShippingAddressModel?> getShippingAddress(
      {required int currentPage, required int limit}) async {
    final response =
        await api.get("api/address/?page=$currentPage&limit=$limit");
    if (response.statusCode == 200) {
      return ShippingAddressModel.fromJson(response.data);
    }
    return null;
  }

  Future createShipping({required Map<String, dynamic> addressData}) async {
    final response = await api.post("api/address/add", data: addressData);
    if (response.statusCode == 200) {
      return response.data;
    }
    return null;
  }

  Future<ShippingAddressEditModel?> editShipping(
      {required int addressId}) async {
    final response = await api.get("api/address/edit/$addressId");
    if (response.statusCode == 200) {
      return ShippingAddressEditModel.fromJson(response.data);
    }
    return null;
  }

  Future updateShipping({required Map<String, dynamic> addressData}) async {
    final response = await api.put(
      "api/address/update",
      data: addressData,
    );
    if (response.statusCode == 200) {
      return response.data;
    }
    return null;
  }

  Future deleteAddress({required int addressId}) async {
    final response =
        await api.delete("api/address/delete", data: {"id": addressId});
    if (response.statusCode == 200) {
      return response.data;
    }
    return null;
  }
}
