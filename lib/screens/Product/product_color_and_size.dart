import 'package:firebase_project/data/model/product_detail_model.dart';
import 'package:firebase_project/screens/cart/cart_controller.dart';
import 'package:firebase_project/utils/constants/colors.dart';
import 'package:firebase_project/utils/constants/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductColorAndSize extends ConsumerStatefulWidget {
  final Product product;
  const ProductColorAndSize({
    super.key,
    required this.product,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductColorAndSizeState();
}

class _ProductColorAndSizeState extends ConsumerState<ProductColorAndSize> {
  int sizeTapIndex = 0;
  int colorTapIndex = 0;

  @override
  void deactivate() {
    ref.invalidate(attributeDataProvider);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) =>
                  widget.product.attributes![index].name == "Clothing Size"
                      ? _buildSizes(context, widget.product.attributes![index])
                      : _buildColorSelection(
                          context, widget.product.attributes![index]),
              separatorBuilder: (context, index) => SizedBox(height: 20),
              itemCount: widget.product.attributes!.length,
            )

            // SizedBox(height: 20.0.h),
            // _buildSizes(context, data),
          ],
        ),
      ),
    );
  }

  Widget _buildColorSelection(BuildContext context, Attributes attributes) {
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
            itemCount: attributes.values!.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: colorTapIndex == index
                    ? null
                    : () {
                        ref.read(attributeDataProvider.notifier).update(
                          (state) {
                            if (state.isNotEmpty) {
                              for (var i = 0; i < state.length; i++) {
                                if (state[i]['name'] == attributes.name) {
                                  state.removeWhere((element) =>
                                      element['name'] == attributes.name);
                                  state.add(
                                    {
                                      "name": attributes.name,
                                      "values": attributes.values![index],
                                    },
                                  );
                                } else {
                                  state.add(
                                    {
                                      "name": attributes.name,
                                      "values": attributes.values![index],
                                    },
                                  );
                                }
                              }
                            } else {
                              state.add(
                                {
                                  "name": attributes.name,
                                  "values": attributes.values![index],
                                },
                              );
                            }

                            return state;
                          },
                        );
                        print(ref.read(attributeDataProvider));

                        setState(() {
                          colorTapIndex = index;
                        });
                      },
                child: Container(
                  margin: EdgeInsets.only(right: 10.0.w),
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                  decoration: BoxDecoration(
                      color: colorTapIndex == index
                          ? AppColors.secondary
                          : AppColors.white,
                      borderRadius: BorderRadius.circular(5.0.r)),
                  child: Center(
                    child: Text(
                      attributes.values![index],
                      style: FontStyles.montserratRegular14().copyWith(
                          color: colorTapIndex == index
                              ? AppColors.darkerGrey
                              : AppColors.textSecondary),
                    ),
                  ),
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

  Widget _buildSizes(BuildContext context, Attributes attributes) {
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
            itemCount: attributes.values!.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: sizeTapIndex == index
                    ? null
                    : () {
                        ref.read(attributeDataProvider.notifier).update(
                          (state) {
                            if (state.isNotEmpty) {
                              for (var i = 0; i < state.length; i++) {
                                if (state[i]['name'] == attributes.name) {
                                  state.removeWhere((element) =>
                                      element['name'] == attributes.name);
                                  state.add(
                                    {
                                      "name": attributes.name,
                                      "values": attributes.values![index],
                                    },
                                  );
                                } else {
                                  state.add(
                                    {
                                      "name": attributes.name,
                                      "values": attributes.values![index],
                                    },
                                  );
                                }
                              }
                            } else {
                              state.add(
                                {
                                  "name": attributes.name,
                                  "values": attributes.values![index],
                                },
                              );
                            }

                            return state;
                          },
                        );

                        print(ref.read(attributeDataProvider));

                        setState(() {
                          sizeTapIndex = index;
                        });
                      },
                child: Container(
                  margin: EdgeInsets.only(right: 10.0.w),
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                  decoration: BoxDecoration(
                    color: sizeTapIndex == index
                        ? AppColors.secondary
                        : AppColors.white,
                    borderRadius: BorderRadius.circular(5.0.r),
                  ),
                  child: Center(
                    child: Text(
                      attributes.values![index],
                      style: FontStyles.montserratRegular14().copyWith(
                          color: sizeTapIndex == index
                              ? AppColors.darkerGrey
                              : AppColors.textSecondary),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
