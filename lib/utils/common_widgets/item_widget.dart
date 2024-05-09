import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_project/screens/Favorite/favorite_controller.dart';
import 'package:firebase_project/data/model/favorite_model.dart';
import 'package:firebase_project/data/model/home_model.dart';
import 'package:firebase_project/utils/common_widgets/dialog_components.dart';
import 'package:firebase_project/utils/common_widgets/shimmer_effect.dart';
import 'package:firebase_project/utils/constants/colors.dart';
import 'package:firebase_project/utils/constants/font_styles.dart';
import 'package:firebase_project/utils/constants/functions.dart';
import 'package:firebase_project/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemWidget extends ConsumerStatefulWidget {
  const ItemWidget({this.product, this.favoriteIcon, super.key, this.wishlist});
  final Products? product;
  final Wishlist? wishlist;
  final bool? favoriteIcon;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends ConsumerState<ItemWidget> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFeaturedWidget(context),
        _buildFeaturedItemText(context),
        _buildFeaturedItemPrice(context),
      ],
    );
  }

  Widget _buildFeaturedWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                height: 153.h,
                width: 163.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: CachedNetworkImage(
                  imageUrl: widget.product?.image ?? widget.wishlist!.image!,
                  fit: BoxFit.cover,
                  placeholder: (context, name) {
                    return ShimmerEffect(
                        borderRadius: 10.0,
                        height: AppDeviceUtils.getScreenHeight(context) * .15,
                        width: AppDeviceUtils.getScreenWidth(context) * .40);
                  },
                  errorWidget: (context, error, child) {
                    return ShimmerEffect(
                      borderRadius: 10.0,
                      height: AppDeviceUtils.getScreenHeight(context) * .20,
                      width: AppDeviceUtils.getScreenWidth(context) * .45,
                    );
                  },
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              width: 47.0,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                gradient: LinearGradient(
                  colors: [Color(0xFFF49763), Color(0xFFD23A3A)],
                  stops: [0, 1],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
              ),
              child: Center(
                child: Text(
                  '50%',
                  style: FontStyles.montserratBold17()
                      .copyWith(fontSize: 11.0, color: AppColors.white),
                ),
              ),
            ),
            widget.favoriteIcon!
                ? Positioned(
                    top: 5,
                    right: 5.0,
                    child: Container(
                        height: 24.0,
                        width: 24.0,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(36.0),
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            AlertAction action =
                                await DialogComponents.confirmDialog(
                                    context, "Do you want to remove this");

                            if (action == AlertAction.ok) {
                              await ref
                                  .read(favoriteProvider.notifier)
                                  .deleteFavorite(
                                      productId: widget.wishlist!.id!)
                                  .then((value) {
                                if (value['status'] == 200) {
                                  ref
                                      .read(favoriteProvider.notifier)
                                      .wishlist
                                      .clear();
                                  ref
                                      .read(favoriteProvider.notifier)
                                      .currentPage = 1;
                                  ref.invalidate(favoriteProvider);
                                }
                              });
                            }
                          },
                          child: Icon(
                            Icons.cancel,
                            color: AppColors.primary,
                          ),
                        )),
                  )
                : const SizedBox.shrink(),
            // widget.favoriteIcon!
            //     ? Positioned(
            //         bottom: -15.0,
            //         right: 10.0,
            //         child: Container(
            //             height: 36.0,
            //             width: 36.0,
            //             decoration: BoxDecoration(
            //               color: AppColors.white,
            //               borderRadius: BorderRadius.circular(36.0),
            //             ),
            //             child: GestureDetector(
            //               onTap: () {
            //                 setState(() {
            //                   isFavorite = !isFavorite;
            //                 });
            //               },
            //               child: Icon(
            //                 isFavorite ? Icons.favorite : Icons.favorite_border,
            //                 color:
            //                     isFavorite ? AppColors.secondary : Colors.black,
            //               ),
            //             )),
            //       )
            //     : const SizedBox(height: 0, width: 0),
          ],
        ),
        _buildRatings(context),
      ],
    );
  }

  Widget _buildRatings(BuildContext context) {
    return SizedBox(
      height: 20,
      width: AppDeviceUtils.getScreenWidth(context),
      child: ListView.builder(
        itemCount: 5,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return const Icon(
            Icons.star,
            color: AppColors.grey,
            size: 10.0,
          );
        },
      ),
    );
  }

  Widget _buildFeaturedItemText(BuildContext context) {
    return SizedBox(
      width: AppDeviceUtils.getScreenWidth(context) * .40,
      child: Text(
        widget.product?.title ?? widget.wishlist!.title!,
        maxLines: 2,
        style: FontStyles.montserratRegular13().copyWith(
          color: const Color(0xFF34283E),
        ),
      ),
    );
  }

  Widget _buildFeaturedItemPrice(BuildContext context) {
    return SizedBox(
      width: AppDeviceUtils.getScreenWidth(context) * .40,
      child: Text(
        indianRupee(widget.product?.price.toString() ??
            widget.wishlist!.price!.toString()),
        style: FontStyles.montserratBold17(),
      ),
    );
  }
}





// class ItemWidget extends StatefulWidget {
  
//   @override
//   State<ItemWidget> createState() => _ItemWidgetState();
// }

// class _ItemWidgetState extends State<ItemWidget> {
//   bool isFavorite = false;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildFeaturedWidget(context),
//         _buildFeaturedItemText(context),
//         _buildFeaturedItemPrice(context),
//       ],
//     );
//   }

//   Widget _buildFeaturedWidget(BuildContext context, WidgetRef ref) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Stack(
//           clipBehavior: Clip.none,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(10.0),
//               child: Container(
//                 height: 153.h,
//                 width: 163.w,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 child: CachedNetworkImage(
//                   imageUrl: widget.product?.image ?? widget.wishlist!.image!,
//                   fit: BoxFit.cover,
//                   placeholder: (context, name) {
//                     return ShimmerEffect(
//                         borderRadius: 10.0,
//                         height: AppDeviceUtils.getScreenHeight(context) * .15,
//                         width: AppDeviceUtils.getScreenWidth(context) * .40);
//                   },
//                   errorWidget: (context, error, child) {
//                     return ShimmerEffect(
//                       borderRadius: 10.0,
//                       height: AppDeviceUtils.getScreenHeight(context) * .20,
//                       width: AppDeviceUtils.getScreenWidth(context) * .45,
//                     );
//                   },
//                 ),
//               ),
//             ),
//             Container(
//               margin: const EdgeInsets.only(top: 10.0),
//               width: 47.0,
//               decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   bottomRight: Radius.circular(10.0),
//                   topRight: Radius.circular(10.0),
//                 ),
//                 gradient: LinearGradient(
//                   colors: [Color(0xFFF49763), Color(0xFFD23A3A)],
//                   stops: [0, 1],
//                   begin: Alignment.bottomRight,
//                   end: Alignment.topLeft,
//                 ),
//               ),
//               child: Center(
//                 child: Text(
//                   '50%',
//                   style: FontStyles.montserratBold17()
//                       .copyWith(fontSize: 11.0, color: AppColors.white),
//                 ),
//               ),
//             ),
//             widget.favoriteIcon!
//                 ? Positioned(
//                     top: 5,
//                     // bottom: -15.0,
//                     right: 5.0,
//                     child: Container(
//                         height: 24.0,
//                         width: 24.0,
//                         decoration: BoxDecoration(
//                           color: AppColors.white,
//                           borderRadius: BorderRadius.circular(36.0),
//                         ),
//                         child: GestureDetector(
//                           onTap: () async {
//                             AlertAction action =
//                                 await DialogComponents.confirmDialog(context,
//                                     "Do you want to remove this product");

//                             if (action == AlertAction.ok) {
                              
//                             }
//                           },
//                           child: Icon(
//                             Icons.cancel,
//                             color: AppColors.primary,
//                           ),
//                         )),
//                   )
//                 : const SizedBox(height: 0, width: 0),
//             // widget.favoriteIcon!
//             //     ? Positioned(
//             //         bottom: -15.0,
//             //         right: 10.0,
//             //         child: Container(
//             //             height: 36.0,
//             //             width: 36.0,
//             //             decoration: BoxDecoration(
//             //               color: AppColors.white,
//             //               borderRadius: BorderRadius.circular(36.0),
//             //             ),
//             //             child: GestureDetector(
//             //               onTap: () {
//             //                 setState(() {
//             //                   isFavorite = !isFavorite;
//             //                 });
//             //               },
//             //               child: Icon(
//             //                 isFavorite ? Icons.favorite : Icons.favorite_border,
//             //                 color:
//             //                     isFavorite ? AppColors.secondary : Colors.black,
//             //               ),
//             //             )),
//             //       )
//             //     : const SizedBox(height: 0, width: 0),
//           ],
//         ),
//         _buildRatings(context),
//       ],
//     );
//   }

//   Widget _buildRatings(BuildContext context) {
//     return SizedBox(
//       height: 20,
//       width: AppDeviceUtils.getScreenWidth(context),
//       child: ListView.builder(
//         itemCount: 5,
//         shrinkWrap: true,
//         scrollDirection: Axis.horizontal,
//         itemBuilder: (context, index) {
//           return const Icon(
//             Icons.star,
//             color: AppColors.grey,
//             size: 10.0,
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildFeaturedItemText(BuildContext context) {
//     return SizedBox(
//       width: AppDeviceUtils.getScreenWidth(context) * .40,
//       child: Text(
//         widget.product?.title ?? widget.wishlist!.title!,
//         maxLines: 2,
//         style: FontStyles.montserratRegular13().copyWith(
//           color: const Color(0xFF34283E),
//         ),
//       ),
//     );
//   }

//   Widget _buildFeaturedItemPrice(BuildContext context) {
//     return SizedBox(
//       width: AppDeviceUtils.getScreenWidth(context) * .40,
//       child: Text(
//         '\₹${widget.product?.price ?? widget.wishlist!.price!}',
//         style: FontStyles.montserratBold17(),
//       ),
//     );
//   }
// }
