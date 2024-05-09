import 'dart:io';
import 'package:firebase_project/screens/cart/cart_controller.dart';
import 'package:firebase_project/data/model/cart_model.dart';
import 'package:firebase_project/screens/checkout/check_out_screen.dart';
import 'package:firebase_project/utils/common_widgets/app_button.dart';
import 'package:firebase_project/utils/common_widgets/cart_tile.dart';
import 'package:firebase_project/utils/common_widgets/circular_progress.dart';
import 'package:firebase_project/utils/common_widgets/custom_app_bar.dart';
import 'package:firebase_project/utils/constants/colors.dart';
import 'package:firebase_project/utils/constants/font_styles.dart';
import 'package:firebase_project/utils/constants/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Cart extends ConsumerWidget {
  static const String routeName = 'cart';
  const Cart({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    return cart.when(
      error: (error, stackTrace) => ErrorWidget(error),
      loading: () => CircularProgress(),
      data: (data) => Scaffold(
        backgroundColor: AppColors.white,
        appBar: _buildAppBar(context),
        body: data.carts!.isNotEmpty
            ? _buildBody(context, data.carts!, ref)
            : Center(child: Text("No items in cart")),
        bottomNavigationBar: data.carts!.isNotEmpty
            ? _buildBottomSheet(context, data)
            : SizedBox.shrink(),
      ),
    );
  }

  PreferredSize _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize:
          Size(double.infinity, MediaQuery.of(context).size.height * .20.h),
      child: CustomAppBar(
        isHome: false,
        title: 'Cart',
        fixedHeight: 88.0,
        enableSearchField: false,
        leadingIcon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
        leadingOnTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context, CartModel? data) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0.r),
          topRight: Radius.circular(20.0.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total price', style: FontStyles.montserratBold19()),
                Text(
                  indianRupee(data!.totalAmount.toString()),
                  style: FontStyles.montserratBold19(),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10.0.h),
            child: AppButton.button(
              text: 'Check Out',
              textColor: AppColors.white,
              color: AppColors.primary,
              height: 48.h,
              width: size.width - 20.w,
              onTap: () {
                Navigator.pushNamed(context, CheckOut.routeName);
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildBody(BuildContext context, List<Carts> data, WidgetRef ref) {
  return ListView.builder(
    itemCount: data.length,
    shrinkWrap: true,
    itemBuilder: (context, index) {
      return Container(
        color: AppColors.softGrey,
        margin: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.0.h),
        child: CartTile(
          cart: data[index],
        ),
      );
    },
  );
}
