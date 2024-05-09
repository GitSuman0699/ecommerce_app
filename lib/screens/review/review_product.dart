import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_project/data/model/product_detail_model.dart';
import 'package:firebase_project/screens/product_detail/product_controller.dart';
import 'package:firebase_project/screens/review/review_controller.dart';
import 'package:firebase_project/utils/common_widgets/app_button.dart';
import 'package:firebase_project/utils/common_widgets/custom_app_bar.dart';
import 'package:firebase_project/utils/common_widgets/shimmer_effect.dart';
import 'package:firebase_project/utils/constants/colors.dart';
import 'package:firebase_project/utils/constants/font_styles.dart';
import 'package:firebase_project/utils/device/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ReviewProductScreen extends ConsumerStatefulWidget {
  final Product product;
  const ReviewProductScreen({
    super.key,
    required this.product,
  });
  static const String routeName = 'review';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ReviewProductScreenState();
}

class _ReviewProductScreenState extends ConsumerState<ReviewProductScreen> {
  final formKey = GlobalKey<FormBuilderState>();

  @override
  void deactivate() {
    super.deactivate();
    ref.invalidate(ratingStarProvider);
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size(double.infinity, MediaQuery.of(context).size.height * .20),
        child: CustomAppBar(
          isHome: false,
          enableSearchField: false,
          fixedHeight: 88.0,
          leadingIcon: Icons.arrow_back,
          leadingOnTap: () {
            Navigator.pop(context);
          },
          title: "Review Product",
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CachedNetworkImage(
                height: 120,
                width: 100,
                imageUrl: widget.product.image!,
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
              UIHelper.verticalSpaceMedium(),
              Text(
                widget.product.title!,
                style: FontStyles.montserratBold13(),
              ),
              UIHelper.verticalSpaceMedium(),
              RatingBar.builder(
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                  ref
                      .read(ratingStarProvider.notifier)
                      .update((state) => rating.toInt());
                },
              ),
              UIHelper.verticalSpaceMedium(),
              Text(
                "Write a Review",
                style: FontStyles.montserratBold11(),
                textAlign: TextAlign.start,
              ),
              UIHelper.verticalSpaceMedium(),
              SizedBox(
                width: MediaQuery.of(context).size.width - 70,
                child: FormBuilder(
                  key: formKey,
                  child: FormBuilderTextField(
                    enableSuggestions: true,
                    name: 'review',
                    style: FontStyles.montserratRegular13(),
                    decoration: InputDecoration(
                      // labelText: 'Description',
                      contentPadding: EdgeInsets.all(16.0.sp),
                      hintText:
                          "How is the product? Did you like it? Did you hate it?",
                    ),
                    maxLines: 7,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                ),
              ),
              UIHelper.verticalSpaceLarge(),
              AppButton.button(
                text: "Submit",
                color: AppColors.primary,
                height: 48.0.h,
                width: MediaQuery.of(context).size.width - 70,
                onTap: () async {
                  if (formKey.currentState!.saveAndValidate()) {
                    if (ref.read(ratingStarProvider) != 0.0) {
                      await ref
                          .read(reviewSubmitProvider(
                        {
                          "product_id": widget.product.id,
                          "review": formKey.currentState!.value['review']
                              .toString()
                              .trim(),
                        },
                      ).future)
                          .then((value) {
                        if (value['status'] == 200) {
                          ref.invalidate(productDetailProvider);
                          Navigator.pop(context);
                        }
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please give rating")));
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
