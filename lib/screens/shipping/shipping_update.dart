import 'package:firebase_project/data/model/shipping_address_edit_model.dart';
import 'package:firebase_project/screens/CheckOut/checkout_controller.dart';
import 'package:firebase_project/screens/shipping/shipping_address_controller.dart';
import 'package:firebase_project/utils/common_widgets/app_button.dart';
import 'package:firebase_project/utils/common_widgets/circular_progress.dart';
import 'package:firebase_project/utils/common_widgets/custom_app_bar.dart';
import 'package:firebase_project/utils/constants/colors.dart';
import 'package:firebase_project/utils/device/device_utility.dart';
import 'package:firebase_project/utils/device/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ShippingUpdateScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> data;
  // final bool? fromCheckout;
  // final int addressId;
  static const String routeName = 'shippingUpdate';
  const ShippingUpdateScreen({
    super.key,
    required this.data,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ShippingUpdateScreenState();
}

class _ShippingUpdateScreenState extends ConsumerState<ShippingUpdateScreen> {
  final formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    final shippingEdit = ref.watch(shippingEditProvider(widget.data['id']));
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: _buildAppBar(context),
        body: shippingEdit.when(
          error: (error, stackTrace) => ErrorWidget(error),
          loading: () => CircularProgress(),
          data: (data) => SingleChildScrollView(
              child: _builForm(
            formKey,
            context,
            data!,
          )),
        ));
  }

  PreferredSize _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize:
          Size(double.infinity, MediaQuery.of(context).size.height * .20),
      child: CustomAppBar(
        isHome: false,
        title: 'Shipping Update',
        fixedHeight: 88.0,
        enableSearchField: false,
        leadingIcon: Icons.arrow_back,
        leadingOnTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  FormBuilder _builForm(
    GlobalKey<FormBuilderState> formKey,
    BuildContext context,
    ShippingAddressEditModel data,
  ) {
    return FormBuilder(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FormBuilderTextField(
              autofillHints: const [AutofillHints.postalCode],
              name: 'name',
              enableSuggestions: true,
              initialValue: data.address!.name,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person),
                labelText: 'Name*',
                labelStyle: const TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.only(left: 25, top: 15, bottom: 15),
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: 'Name required'),
              ]),
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
            ),
            UIHelper.verticalSpaceMedium(),
            FormBuilderTextField(
              autofillHints: const [AutofillHints.postalCode],
              enableSuggestions: true,
              name: 'address',
              initialValue: data.address!.address,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.location_city),
                labelText: 'Address*',
                labelStyle: const TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.only(left: 25, top: 15, bottom: 15),
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: 'Name required'),
              ]),
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
            ),
            UIHelper.verticalSpaceMedium(),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: FormBuilderTextField(
                    autofillHints: const [AutofillHints.postalCode],
                    enableSuggestions: true,
                    name: 'pincode',
                    initialValue: data.address!.pincode,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.location_city),
                      labelText: 'Pincode*',
                      labelStyle: const TextStyle(color: Colors.grey),
                      contentPadding:
                          EdgeInsets.only(left: 25, top: 15, bottom: 15),
                    ),
                    onChanged: (code) {
                      if (code!.length == 6) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      }
                    },
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.integer(),
                      FormBuilderValidators.required(
                          errorText: 'Pincode required'),
                    ]),
                  ),
                ),
                UIHelper.horizontalSpaceSmall(),
                Expanded(
                  flex: 6,
                  child: FormBuilderTextField(
                    autofillHints: const [AutofillHints.postalCode],
                    enableSuggestions: true,
                    name: 'city',
                    initialValue: data.address!.city,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.location_city),
                      labelText: 'City*',
                      labelStyle: const TextStyle(color: Colors.grey),
                      contentPadding:
                          EdgeInsets.only(left: 25, top: 15, bottom: 15),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'City required'),
                    ]),
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                  ),
                ),
              ],
            ),
            UIHelper.verticalSpaceMedium(),
            Row(
              children: [
                Expanded(
                  flex: 6,
                  child: FormBuilderTextField(
                    autofillHints: const [AutofillHints.postalCode],
                    enableSuggestions: true,
                    name: 'state',
                    initialValue: data.address!.state,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.location_city),
                      labelText: 'State*',
                      labelStyle: const TextStyle(color: Colors.grey),
                      contentPadding:
                          EdgeInsets.only(left: 25, top: 15, bottom: 15),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'State required'),
                    ]),
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                  ),
                ),
                UIHelper.horizontalSpaceSmall(),
                Expanded(
                  flex: 4,
                  child: FormBuilderTextField(
                    readOnly: true,
                    initialValue: 'India',
                    autofillHints: const [AutofillHints.postalCode],
                    name: 'country',
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.location_city),
                      labelText: 'Country*',
                      labelStyle: const TextStyle(color: Colors.grey),
                      contentPadding:
                          EdgeInsets.only(left: 25, top: 15, bottom: 15),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'City required'),
                    ]),
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                  ),
                ),
              ],
            ),
            UIHelper.verticalSpaceMedium(),
            FormBuilderTextField(
              autofillHints: const [AutofillHints.postalCode],
              enableSuggestions: true,
              name: 'phone',
              initialValue: data.address!.phone,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.phone),
                labelText: 'Mobile*',
                labelStyle: const TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.only(left: 25, top: 15, bottom: 15),
              ),
              onChanged: (code) {
                if (code!.length == 10) {
                  FocusScope.of(context).requestFocus(FocusNode());
                }
              },
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.integer(),
                FormBuilderValidators.required(errorText: 'Mobile required'),
              ]),
            ),
            UIHelper.verticalSpaceMedium(),
            FormBuilderTextField(
              autofillHints: const [AutofillHints.postalCode],
              enableSuggestions: true,
              name: 'alt_phone',
              initialValue: data.address!.altPhone,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.phone),
                labelText: 'Alternate Mobile',
                labelStyle: const TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.only(left: 25, top: 15, bottom: 15),
              ),
              onChanged: (code) {
                if (code!.length == 10) {
                  FocusScope.of(context).requestFocus(FocusNode());
                }
              },
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.integer(),
              ]),
            ),
            // UIHelper.verticalSpaceMedium(),
            FormBuilderCheckbox(
              name: 'default_address',
              initialValue: data.address!.defaultAddress == 1 ? true : false,
              enabled: data.address!.defaultAddress == 1 ? false : true,
              tristate: false,
              activeColor: AppColors.primary,
              title: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Make this address default',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            AppButton.button(
              text: 'Update',
              textColor: AppColors.white,
              width: AppDeviceUtils.getScreenWidth(context),
              color: AppColors.primary,
              onTap: () async {
                if (formKey.currentState!.saveAndValidate()) {
                  await ref
                      .read(shippingAddressProvider.notifier)
                      .updateAddress(
                          addressData: formKey.currentState!.value,
                          shippingId: data.address!.id!)
                      .then((value) {
                    if (value['status'] == 200) {
                      if (widget.data['from_checkout'] == true) {
                        ref.invalidate(shippingAddressProvider);
                        ref.invalidate(checkoutProvider);
                        Navigator.pop(context);
                      } else {
                        ref.invalidate(shippingAddressProvider);
                        Navigator.pop(context);
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(value['message'])));
                    }
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
