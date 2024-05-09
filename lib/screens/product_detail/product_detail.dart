import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_project/data/model/review_model.dart';
import 'package:firebase_project/screens/product_detail/add_to_cart_button.dart';
import 'package:firebase_project/screens/product_detail/product_all_review.dart';
import 'package:firebase_project/screens/product_detail/product_color_and_size.dart';
import 'package:firebase_project/screens/product_detail/product_controller.dart';
import 'package:firebase_project/data/model/product_detail_model.dart' as pr;
import 'package:firebase_project/screens/cart/cart_controller.dart';
import 'package:firebase_project/screens/review/review_product.dart';
import 'package:firebase_project/utils/common_widgets/app_button.dart';
import 'package:firebase_project/utils/common_widgets/item_widget.dart';
import 'package:firebase_project/utils/common_widgets/shimmer_effect.dart';
import 'package:firebase_project/utils/constants/colors.dart';
import 'package:firebase_project/utils/constants/font_styles.dart';
import 'package:firebase_project/utils/constants/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_project/data/model/review_model.dart' as rw;

// ignore: must_be_immutable
class ProductDetail extends ConsumerWidget {
  static const String routeName = 'product';
  final int productId;
  const ProductDetail({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, child) {
        final productDetail = ref.watch(productDetailProvider(productId));
        return productDetail.when(
          error: (error, stackTrace) => ErrorWidget(error),
          loading: () => Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          data: (data) => Scaffold(
            backgroundColor: AppColors.white,
            body: _buildBody(context, data!),
            bottomNavigationBar: AddTOCartButton(
              product: data.product!,
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, pr.ProductDetailModel data) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            collapsedHeight: kToolbarHeight,
            expandedHeight: screenHeight * .40.h,
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: data.product!.image!,
                fit: BoxFit.cover,
                placeholder: (context, name) {
                  return ShimmerEffect(
                    borderRadius: 0.0.r,
                    height: screenHeight * .40.h,
                    width: screenWidth,
                  );
                },
                errorWidget: (context, error, child) {
                  return ShimmerEffect(
                    borderRadius: 0.0.r,
                    height: screenHeight * .40.h,
                    width: screenWidth,
                  );
                },
              ),
            ),
          ),
        ];
      },
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAboutProduct(context, data),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ProductColorAndSize(product: data.product!),
                  // _buildColorAndSizeSelection(context, data),
                  SizedBox(height: 10.0.h),
                  _buildProductDetail(context, data),
                  SizedBox(height: 10.0.h),
                  _buildReviews(context, data),
                  SizedBox(height: 10.0.h),
                  // _buildRelatedProduct(context)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildReviews(BuildContext context, pr.ProductDetailModel data) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(10.0.r)),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Reviews',
                style: FontStyles.montserratBold19()
                    .copyWith(color: const Color(0xFF34283E)),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ReviewProductScreen.routeName,
                      arguments: data.product);
                },
                child: Chip(
                  padding: EdgeInsets.all(0),
                  labelPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  label: Text(
                    'Rate',
                    style: FontStyles.montserratBold12().copyWith(),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0.h),
          data.reviews!.isEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("No Reviews"),
                  ],
                )
              : reviewListBuilder(data: data),
          data.reviews!.isEmpty
              ? SizedBox.shrink()
              : Divider(
                  color: Colors.grey[200],
                ),
          Visibility(
            visible: data.reviews!.isNotEmpty && data.reviews!.length >= 5,
            child: ListTile(
              onTap: () {
                Navigator.of(context).pushNamed(AllReviewScreen.routeName,
                    arguments: data.product!.id);
              },
              title: Text("See all review"),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAboutProduct(BuildContext context, pr.ProductDetailModel data) {
    return Container(
      color: AppColors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildRatings(context, data),
                Text(
                  data.product!.stock! != 0 ? 'In Stock' : 'Out Of Stock',
                  style: FontStyles.montserratBold12()
                      .copyWith(color: AppColors.darkGrey),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: Text(
              data.product!.title!,
              style: FontStyles.montserratRegular19(),
            ),
          ),
          _buildPrice(context, indianRupee(data.product!.price.toString())),
        ],
      ),
    );
  }

  Widget _buildRatings(BuildContext context, pr.ProductDetailModel data) {
    return Row(
      children: [
        RatingBar.builder(
          updateOnDrag: true,
          ignoreGestures: true,
          direction: Axis.horizontal,
          itemSize: 15,
          initialRating: double.parse(data.overallRating!),
          allowHalfRating: true,
          itemCount: 5,
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            null;
          },
        ),
        Text(
          ' ${data.overallRating} rating',
          style: FontStyles.montserratRegular12(),
        ),
      ],
    );
  }

  Widget _buildPrice(BuildContext context, String price) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, top: 10.0.h),
      child: Text(
        price,
        style: FontStyles.montserratBold25(),
      ),
    );
  }

  Widget _buildColorSelection(
      BuildContext context, pr.ProductDetailModel data) {
    List<String> colors = [
      'assets/product/pic1.png',
      'assets/product/pic2.png',
      'assets/product/pic3.png',
      'assets/product/pic4.png',
      'assets/product/pic5.png',
      'assets/product/pic6.png',
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Colors',
          style: FontStyles.montserratSemiBold14(),
        ),
        SizedBox(height: 20.0.h),
        SizedBox(
          height: 47.0.h,
          child: ListView.separated(
            itemCount: colors.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                height: 47.h,
                width: 47.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(colors[index]),
                  ),
                  borderRadius: BorderRadius.circular(10.0.r),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(width: 10.0.w);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSizes(BuildContext context, pr.ProductDetailModel data) {
    List<String> titles = ['XXS', 'XS', 'S', 'M', 'L', 'XL'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sizes',
          style: FontStyles.montserratSemiBold14(),
        ),
        SizedBox(height: 20.0.h),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 50.0.h,
          child: ListView.builder(
            itemCount: titles.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(right: 10.0.w),
                padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                decoration: BoxDecoration(
                    color: index == 0 ? AppColors.secondary : AppColors.white,
                    borderRadius: BorderRadius.circular(5.0.r)),
                child: Center(
                  child: Text(
                    titles[index],
                    style: FontStyles.montserratRegular14().copyWith(
                        color: index == 0
                            ? AppColors.white
                            : AppColors.textSecondary),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductDetail(BuildContext context, pr.ProductDetailModel data) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.0.r),
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Product Detail',
            style: FontStyles.montserratBold19(),
          ),
          SizedBox(height: 10.0.h),
          Text(
            data.product!.shortDescription!,
            style: FontStyles.montserratRegular14(),
          ),
        ],
      ),
    );
  }

  // Widget _buildReviews(BuildContext context) {
  //   return Container(
  //     decoration: BoxDecoration(
  //         color: AppColors.white, borderRadius: BorderRadius.circular(10.0.r)),
  //     padding: const EdgeInsets.all(20.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               'Reviews',
  //               style: FontStyles.montserratBold19()
  //                   .copyWith(color: const Color(0xFF34283E)),
  //             ),
  //             GestureDetector(
  //               onTap: () {
  //                 // Navigator.pushNamed(context, Catalogue.routeName);
  //               },
  //               child: Text(
  //                 'See All',
  //                 style: FontStyles.montserratBold12()
  //                     .copyWith(color: const Color(0xFF9B9B9B)),
  //               ),
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 10.0.h),
  //         Text(
  //           'Olha Chabanova',
  //           style: FontStyles.montserratSemiBold14(),
  //         ),
  //         SizedBox(height: 10.0.h),
  //         _buildReviewRatings(context),
  //         SizedBox(height: 10.0.h),
  //         Text(
  //           'I’m old (rolling through my 50’s). But, this is my daughter in law’s favorite color right now.❤️ So I wear it whenever we hang out! She’s my fashion consultant who keeps me on trend🤣',
  //           style: FontStyles.montserratRegular14(),
  //         ),
  //         SizedBox(height: 10.0.h),
  //         Text(
  //           '835 people found this helpful',
  //           style: FontStyles.montserratRegular11(),
  //         ),
  //         SizedBox(height: 10.0.h),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               'Comment',
  //               style: FontStyles.montserratRegular14()
  //                   .copyWith(decoration: TextDecoration.underline),
  //             ),
  //             Row(
  //               children: [
  //                 Text(
  //                   'Helpful',
  //                   style: FontStyles.montserratRegular12(),
  //                 ),
  //                 SizedBox(width: 10.0.w),
  //                 const Icon(Icons.thumb_up)
  //               ],
  //             )
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildReviewRatings(BuildContext context) {
  //   return SizedBox(
  //     height: 20.0.h,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         ListView.builder(
  //             itemCount: 5,
  //             shrinkWrap: true,
  //             scrollDirection: Axis.horizontal,
  //             itemBuilder: (context, index) {
  //               return const Icon(
  //                 Icons.star,
  //                 color: AppColors.secondary,
  //                 size: 14.0,
  //               );
  //             }),
  //         Text(
  //           'June 5,2021',
  //           style: FontStyles.montserratRegular12(),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildRelatedProduct(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Product related to this item',
            style: FontStyles.montserratBold19()
                .copyWith(color: const Color(0xFF34283E)),
          ),
          SizedBox(height: 10.0.h),
          SizedBox(
            // color: Colors.red,
            height: 310.h,
            // width: 200,
            child: ListView.builder(
                itemCount: 4,
                itemExtent: 180.0.w,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ItemWidget(
                    // index: index,
                    favoriteIcon: true,
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget _buildBottomSheet(
      {BuildContext? context,
      Function()? onTap,
      bool? favorite,
      pr.ProductDetailModel? data,
      WidgetRef? ref}) {
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
                Navigator.pop(context!);
              },
              child: const Icon(Icons.arrow_back)),
          AppButton.button(
            text: 'Add to cart',
            color: AppColors.primary,
            height: 48.0.h,
            width: 215.0.w,
            onTap: onTap,
          ),
          favorite!
              ? GestureDetector(
                  onTap: () async {
                    await ref!
                        .read(productDetailProvider(productId).notifier)
                        .addFavorite(productId: productId)
                        .then((value) {
                      if (value['status'] == 200) {
                        ref.invalidate(productDetailProvider);
                      }
                    });
                  },
                  child: Icon(
                    data!.product!.wishlist!
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: data.product!.wishlist!
                        ? Colors.redAccent
                        : Colors.black,
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }

  _buildCartModalSheet(
      BuildContext context, pr.ProductDetailModel data, WidgetRef ref) {
    showModalBottomSheet(
      backgroundColor: AppColors.white,
      isScrollControlled: true,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0.r),
              topLeft: Radius.circular(20.0.r))),
      context: context,
      builder: (_) {
        return Container(
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0.r),
              topLeft: Radius.circular(20.0.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 5.0.h,
                  width: 60.0.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0.r),
                    color: AppColors.lightGrey,
                  ),
                ),
              ),
              SizedBox(height: 10.0.h),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
              //   child: const CartTile(),
              // ),
              SizedBox(height: 10.0.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: _buildColorSelection(context, data),
              ),
              SizedBox(height: 10.0.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: _buildSizes(context, data),
              ),
              SizedBox(height: 10.0.h),
              _buildBottomSheet(
                context: context,
                ref: ref,
                data: data,
                favorite: false,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

ListView reviewListBuilder(
    {pr.ProductDetailModel? data, List<rw.Reviews>? review}) {
  return ListView.separated(
    separatorBuilder: (context, index) => Divider(
      color: Colors.grey[200],
    ),
    padding: EdgeInsets.all(0),
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: data?.reviews?.length ?? review!.length,
    itemBuilder: (context, index) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            data?.reviews?[index].username ?? review![index].username!,
            style: FontStyles.montserratSemiBold14(),
          ),
          // SizedBox(height: 5.0.h),
          _buildReviewRatings(
              context: context,
              data: data?.reviews?[index],
              review: review?[index]),
          SizedBox(height: 10.0.h),
          Text(
            data?.reviews?[index].review ?? review![index].review!,
            style: FontStyles.montserratRegular14(),
          ),
          SizedBox(height: 10.0.h),
        ],
      );
    },
  );
}

Widget _buildReviewRatings(
    {required BuildContext context, pr.Reviews? data, rw.Reviews? review}) {
  return SizedBox(
    height: 20.0.h,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ListView.builder(
          itemCount: 5,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Icon(
              Icons.star,
              color: index < (data?.rating ?? review!.rating!)
                  ? Colors.amber
                  : AppColors.secondary,
              size: 14.0,
            );
          },
        ),
        Text(
          data?.date ?? review!.date!,
          style: FontStyles.montserratRegular12(),
        ),
      ],
    ),
  );
}
