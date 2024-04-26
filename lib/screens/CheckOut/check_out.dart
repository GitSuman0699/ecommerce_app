import 'package:firebase_project/data/model/checkout_model.dart' as ch;
import 'package:firebase_project/data/model/checkout_model.dart';
import 'package:firebase_project/screens/CheckOut/checkout_controller.dart';
import 'package:firebase_project/screens/CheckOut/order_success_screen.dart';
import 'package:firebase_project/screens/CheckOut/payment_option_widget.dart';
import 'package:firebase_project/screens/cart/cart.dart';
import 'package:firebase_project/screens/orders/order.dart';
import 'package:firebase_project/screens/shipping/shipping_address.dart';
import 'package:firebase_project/utils/common_widgets/app_button.dart';
import 'package:firebase_project/utils/common_widgets/cart_tile.dart';
import 'package:firebase_project/utils/common_widgets/circular_progress.dart';
import 'package:firebase_project/utils/common_widgets/custom_app_bar.dart';
import 'package:firebase_project/utils/constants/colors.dart';
import 'package:firebase_project/utils/constants/font_styles.dart';
import 'package:firebase_project/utils/constants/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckOut extends ConsumerWidget {
  static const String routeName = 'checkout';
  const CheckOut({super.key});

  static final paymentOptionFormKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkout = ref.watch(checkoutProvider);
    return checkout.when(
      error: (error, stackTrace) => ErrorWidget(error),
      loading: () => CircularProgress(),
      data: (data) => Scaffold(
        backgroundColor: AppColors.white,
        appBar: _buildAppBar(context),
        body: _buildCheckoutBody(context, data!),
        bottomNavigationBar: _buildBottomSheet(context, ref, data),
      ),
    );
  }

  PreferredSize _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize:
          Size(double.infinity, MediaQuery.of(context).size.height * .20.h),
      child: CustomAppBar(
        isHome: false,
        title: 'Check Out',
        fixedHeight: 88.0.h,
        enableSearchField: false,
        leadingIcon: Icons.arrow_back,
        leadingOnTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _buildCheckoutBody(BuildContext context, ch.CheckoutModel data) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .75.h,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _buildAddress(context, data),
            _buildItems(context, data),
            // _buildDeliveryMethod(context),
            _buildPaymentOption(context, data),
            _buildOrderSummary(context, data),
          ],
        ),
      ),
    );
  }

  Widget _buildAddress(BuildContext context, ch.CheckoutModel data) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          _buildTitle(context, Icons.location_on_outlined, 'Shipping Address'),
          SizedBox(height: 20.0.h),
          shippingTile(data.address![0], context),
        ],
      ),
    );
  }

  Widget _buildItems(BuildContext context, CheckoutModel data) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          _buildTitle(context, Icons.shopping_bag, 'Items'),
          SizedBox(height: 10.0.h),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: data.carts!.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                color: AppColors.softGrey,
                margin:
                    EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.0.h),
                child: CartTile(
                  cart: data.carts![index],
                  fromCheckout: true,
                ),
              );
            },
          )

          // shippingTile(data.address![0], context),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(BuildContext context, CheckoutModel data) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          _buildTitle(context, Icons.card_giftcard, 'Payment Method'),
          SizedBox(height: 20.0.h),
          PaymentOptionWidget(
            formKey: paymentOptionFormKey,
            paymentMethod: data.paymentMethod,
          )
        ],
      ),
    );
  }

  Widget _buildOrderSummary(BuildContext context, CheckoutModel data) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          _buildTitle(context, Icons.blinds_closed_sharp, 'Order Summary'),
          Container(
            margin: const EdgeInsets.only(
              left: 20.0,
              top: 20.0,
              right: 20.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Items', style: FontStyles.montserratSemiBold14()),
                      Text(data.orderSummary!.totalItems.toString(),
                          style: FontStyles.montserratSemiBold14()),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total price', style: FontStyles.montserratBold19()),
                      Text(
                        indianRupee(data.orderSummary!.totalAmount!.toString()),
                        style: FontStyles.montserratBold19(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryMethod(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(
              context, Icons.directions_car_outlined, 'Delivery Method'),
          SizedBox(height: 20.0.h),
          SizedBox(
            height: screenHeight * .20.h,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: 3,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return _buildDeliveryCard(context,
                    'assets/checkOut/icon${index + 1}.png', '18', '1-2');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethod(BuildContext context) {
    return Container(
      // color: Colors.brown,
      margin: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          _buildTitle(context, Icons.payment_outlined, 'Payment Method'),
          SizedBox(height: 20.0.h),
          _buildPaymentCard(context),
        ],
      ),
    );
  }

  Widget _buildDeliveryCard(
      BuildContext context, String imageLink, String price, String days) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight * .15.h,
      width: screenWidth * .30.w,
      margin: EdgeInsets.only(right: 10.0.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.0.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(
            image: AssetImage(imageLink),
          ),
          // SizedBox(height: 10.0),
          Column(
            children: [
              Text(
                '\$$price',
                style: FontStyles.montserratSemiBold14(),
              ),
              // ignore: prefer_const_constructors
              Text(
                '$days days',
                style: FontStyles.montserratRegular12(),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildPaymentCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.only(top: 9.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Stack(
                clipBehavior: Clip.none,
                children: [
                  Image(
                    image: AssetImage('assets/checkOut/v2.png'),
                  ),
                  Positioned(
                    left: -20,
                    top: -3,
                    // top: 4,
                    child: Image(image: AssetImage('assets/checkOut/v1.png')),
                  ),
                  Positioned(
                      right: -20,
                      top: -3,
                      child:
                          Image(image: AssetImage('assets/checkOut/v3.png'))),
                ],
              ),
              SizedBox(height: 2.0.h),
              const Text('mastercard'),
            ],
          ),
        ),
        title: Text(
          "***** **** ***** 5678",
          style: FontStyles.montserratSemiBold14(),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }

  Widget _buildTitle(
    BuildContext context,
    IconData icon,
    String title,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: AppColors.primary,
            ),
            SizedBox(width: 10.0.w),
            Text(
              title,
              style: FontStyles.montserratBold19(),
            )
          ],
        ),
        Visibility(
          visible: title == 'Shipping Address' || title == 'Items',
          child: InkWell(
            onTap: () {
              title == 'Items'
                  ? Navigator.pop(context)
                  : Navigator.pushNamed(
                      context,
                      ShippingAddress.routeName,
                      arguments: true,
                    );
            },
            child: Container(
              padding: EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppColors.softGrey),
              ),
              child: Text(title == 'Items' ? 'Edit' : 'Change'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSheet(
      BuildContext context, WidgetRef ref, CheckoutModel data) {
    var size = MediaQuery.of(context).size;
    return Visibility(
      visible: ref.watch(paymentTypeProvider) != "",
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0.r),
            topRight: Radius.circular(20.0.r),
          ),
        ),
        child: Container(
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: AppButton.button(
            text: ref.watch(paymentTypeProvider) == "COD"
                ? 'Place Order'
                : "Continue",
            color: AppColors.primary,
            height: 48,
            width: size.width - 20.w,
            onTap: () async {
              if (ref.watch(paymentTypeProvider) == "COD") {
                await ref
                    .read(placeOrderCODProvider(data).future)
                    .then((value) {
                  if (value['status'] == 200) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, OrderSucessScreen.routeName, (route) => false);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(value['message'])));
                  }
                });
              } else {
                // Send to payment screen
              }

              // showDialog(
              //     barrierDismissible: false,
              //     context: context,
              //     builder: (context) {
              //       return makeAlert(context);
              //     });
              // Navigator.pushNamed(context, CheckOut.routeName);
            },
          ),
        ),
      ),
    );
  }

  // static Widget _buildPopContent(BuildContext context) {
  //   return
  // }

  // Widget makeAlert(BuildContext context) {
  //   return AlertDialog(
  //     shape: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(20.0.r),
  //       borderSide: const BorderSide(color: Colors.transparent),
  //     ),
  //     content: OrderSucessScreen(),
  //     contentPadding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
  //     // actionsAlignment: MainAxisAlignment.center,
  //     actions: [
  //       _buildPopContent(context),
  //     ],
  //   );
  // }
}
