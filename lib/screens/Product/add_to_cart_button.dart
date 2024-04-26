import 'package:firebase_project/data/model/product_detail_model.dart';
import 'package:firebase_project/screens/Product/product_controller.dart';
import 'package:firebase_project/screens/cart/cart.dart';
import 'package:firebase_project/screens/cart/cart_controller.dart';
import 'package:firebase_project/utils/common_widgets/app_button.dart';
import 'package:firebase_project/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddTOCartButton extends ConsumerStatefulWidget {
  final Product product;
  const AddTOCartButton({
    super.key,
    required this.product,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddTOCartButtonState();
}

class _AddTOCartButtonState extends ConsumerState<AddTOCartButton> {
  bool addedToCart = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70.0.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0.r),
          topRight: Radius.circular(20.0.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back)),
          AppButton.button(
            text: addedToCart || widget.product.cart!
                ? "Go To Cart"
                : "Add To Cart",
            color: AppColors.primary,
            height: 48.0.h,
            width: 215.0.w,
            onTap: () async {
              if (addedToCart) {
                Navigator.pushNamed(context, Cart.routeName);
              } else {
                if (ref.read(attributeDataProvider).isNotEmpty) {
                  await ref
                      .read(cartProvider.notifier)
                      .addCart(product: widget.product)
                      .then((value) {
                    if (value['status'] == 200) {
                      ref.invalidate(cartProvider);
                      setState(() {
                        addedToCart = true;
                      });
                    }
                  });
                } else {
                  ref.read(attributeDataProvider.notifier).update((state) {
                    for (var i = 0;
                        i < widget.product.attributes!.length;
                        i++) {
                      state.add(
                        {
                          "name": widget.product.attributes![i].name,
                          "values": widget.product.attributes![i].values![0],
                        },
                      );
                    }

                    return state;
                  });

                  await ref
                      .read(cartProvider.notifier)
                      .addCart(product: widget.product)
                      .then((value) {
                    if (value['status'] == 200) {
                      ref.invalidate(cartProvider);
                      setState(() {
                        addedToCart = true;
                      });
                    }
                  });
                }
              }
            },
          ),
          GestureDetector(
            onTap: () async {
              await ref
                  .read(productDetailProvider(widget.product.id!).notifier)
                  .addFavorite(productId: widget.product.id!)
                  .then((value) {
                if (value['status'] == 200) {
                  ref.invalidate(productDetailProvider);
                }
              });
            },
            child: Icon(
              widget.product.wishlist! ? Icons.favorite : Icons.favorite_border,
              color: widget.product.wishlist! ? Colors.redAccent : Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
