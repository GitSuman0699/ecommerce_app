import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_project/screens/cart/cart_controller.dart';
import 'package:firebase_project/data/model/cart_model.dart';
import 'package:firebase_project/utils/common_widgets/dialog_components.dart';
import 'package:firebase_project/utils/constants/colors.dart';
import 'package:firebase_project/utils/constants/font_styles.dart';
import 'package:firebase_project/utils/constants/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartTile extends StatelessWidget {
  final WidgetRef ref;
  final Carts cart;
  const CartTile({super.key, required this.cart, required this.ref});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) async {
              AlertAction action = await DialogComponents.confirmDialog(
                  context, "Do you want remoce this item from cart");

              if (action == AlertAction.ok) {
                final cartDelete =
                    await ref.read(cartProvider.notifier).deleteCartItem(
                          cartId: cart.id!,
                          context: context,
                        );

                if (cartDelete['status'] == 200) {
                  ref.invalidate(cartProvider);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(cartDelete['message']),
                    ),
                  );
                }
              }
            },
            backgroundColor: Colors.red[400]!,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Remove',
            padding: EdgeInsets.zero,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    cart.image!,
                  ),
                ),
                borderRadius: BorderRadius.circular(10.0)),
          ),
          Expanded(
            child: Container(
              height: 80.h,
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cart.title!,
                    style: FontStyles.montserratRegular14(),
                    maxLines: 2,
                  ),
                  // SizedBox(height: 20.0),
                  Text(
                    indianRupee(cart.totalAmount.toString()),
                    style: FontStyles.montserratBold17(),
                  )
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                splashRadius: 1.0,
                onPressed: () async {
                  final cartResponse = await ref
                      .watch(cartProvider.notifier)
                      .addQuantity(cart: cart, context: context);

                  if (cartResponse['status'] == 200) {
                    ref.invalidate(cartProvider);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(cartResponse['message'])));
                  }
                },
                color: AppColors.darkGrey,
                icon: Icon(Icons.add_circle_outline),
              ),
              Text(
                "${cart.quantity}",
                style: TextStyle(color: AppColors.primary),
              ),
              IconButton(
                splashRadius: 1.0,
                onPressed: () async {
                  final cartResponse = await ref
                      .watch(cartProvider.notifier)
                      .removeQuantity(cart: cart, context: context);
                  if (cartResponse != null) {
                    if (cartResponse['status'] == 200) {
                      ref.invalidate(cartProvider);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(cartResponse['message']),
                        ),
                      );
                    }
                  }
                },
                color: AppColors.darkGrey,
                icon: Icon(Icons.remove_circle_outline),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
