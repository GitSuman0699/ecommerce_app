import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/screens/Notifications/notifications.dart';
import 'package:firebase_project/screens/Product/product.dart';
import 'package:firebase_project/screens/auth/authentication_service.dart';
import 'package:firebase_project/screens/catalogue/catalogue.dart';
import 'package:firebase_project/data/model/home_model.dart';
import 'package:firebase_project/dummy/dummy_data.dart';
import 'package:firebase_project/screens/home/home_controller.dart';
import 'package:firebase_project/utils/common_widgets/app_title.dart';
import 'package:firebase_project/utils/common_widgets/catalogue_widget.dart';
import 'package:firebase_project/utils/common_widgets/custom_app_bar.dart';
import 'package:firebase_project/utils/common_widgets/item_widget.dart';
import 'package:firebase_project/utils/common_widgets/shimmer_effect.dart';
import 'package:firebase_project/utils/constants/colors.dart';
import 'package:firebase_project/utils/constants/font_styles.dart';
import 'package:firebase_project/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: _buildCustomAppBar(context),
      drawer: _buildDrawer(context),
      body: _buildBody(context),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final home = ref.watch(homeProvider);
        return home.when(
          error: (error, stackTrace) => ErrorWidget(error),
          loading: () => Center(
            child: CircularProgressIndicator(),
          ),
          data: (data) => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSellerCard(banner: data!.banners!),
                _buildCatalogue(category: data.categories!),
                _buildFeatured(context: context, products: data.products!),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return SizedBox(
      width: AppDeviceUtils.getScreenWidth(context) * .60,
      child: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: AppDeviceUtils.getScreenHeight(context) * .20,
              child: DrawerHeader(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.primary],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    stops: [0, 1],
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(left: 20.0),
                    child: AppTitle(
                      fontStyle: FontStyles.montserratExtraBold18(),
                      marginTop: 0.0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: AppDeviceUtils.getScreenWidth(context) / 2,
              height: AppDeviceUtils.getScreenHeight(context) / 3.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    onTap: () {
                      // Navigator.pop(context);
                      // Navigator.pushNamed(context, Settings.routeName);
                    },
                    leading:
                        const Icon(Icons.settings, color: AppColors.primary),
                    title: Text(
                      'Settings',
                      style: FontStyles.montserratRegular18(),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      // Navigator.pushNamed(context, Settings.routeName);
                    },
                    leading: const Icon(Icons.help_outline,
                        color: AppColors.primary),
                    title: Text(
                      'Help',
                      style: FontStyles.montserratRegular18(),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      AuthenticationService.instance.signOut(context);
                      // Navigator.pushReplacementNamed(
                      //     context, OnBoarding.routeName);
                    },
                    leading: const Icon(Icons.logout_outlined,
                        color: AppColors.primary),
                    title: Text(
                      'Logout',
                      style: FontStyles.montserratRegular18(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSize _buildCustomAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize:
          Size(double.infinity, AppDeviceUtils.getScreenHeight(context) * .20),
      child: CustomAppBar(
        isHome: true,
        enableSearchField: true,
        leadingIcon: Icons.menu,
        leadingOnTap: () {},
        trailingIcon: Icons.notifications_none_outlined,
        trailingOnTap: () async {
          String? bearer =
              await FirebaseAuth.instance.currentUser!.getIdToken();
          print(bearer);
          Map<String, dynamic> decodedToken = JwtDecoder.decode(bearer!);
          print(decodedToken);
          // Navigator.of(context).pushNamed(NotificationScreen.routeName);
        },
        scaffoldKey: _key,
      ),
    );
  }

  Widget _buildSellerCard({required List<Banners> banner}) {
    return Container(
      margin: EdgeInsets.only(left: 20.0.w, right: 20.w, top: 50.0.h),
      height: 88.h,
      width: 343.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0.r),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0.r),
            child: makeSlider(banner: banner),
          ),
          Positioned(
              top: AppDeviceUtils.getScreenHeight(context) * .020.h,
              left: 20.0,
              child: Text(
                'Fashion Sale',
                style: FontStyles.montserratBold25()
                    .copyWith(color: AppColors.white),
              )),
          Positioned(
            top: AppDeviceUtils.getScreenHeight(context) * .070.h,
            left: 20.0.w,
            child: Row(
              children: [
                Text(
                  'See More',
                  style: FontStyles.montserratBold12().copyWith(
                    color: AppColors.secondary,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 12.0.h,
                  color: AppColors.secondary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCatalogue({required List<Categories> category}) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, Catalogue.routeName,
        //     arguments: [true, true]);
      },
      child: Container(
        margin: EdgeInsets.only(
            top: 25.0.h, left: 20.h, right: 20.0.h, bottom: 17.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Catalogue',
                  style: FontStyles.montserratBold19().copyWith(
                    color: const Color(0xFF34283E),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Catalogue.routeName,
                        arguments: [true, true]);
                  },
                  child: Text(
                    'See All ',
                    style: FontStyles.montserratBold12()
                        .copyWith(color: const Color(0xFF9B9B9B)),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: AppDeviceUtils.getScreenWidth(context),
              height: 97.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: category.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CatalogueWidget(
                    height: 88.h,
                    width: 88.w,
                    category: category[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatured(
      {required BuildContext context, required List<Products> products}) {
    return Container(
      margin: EdgeInsets.only(
          left: 20.0.w,
          right: 20.0.w,
          top: 20.h,
          bottom: AppDeviceUtils.getScreenHeight(context) * .09.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Featured',
            style: FontStyles.montserratBold19()
                .copyWith(color: const Color(0xFF34283E)),
          ),
          SizedBox(height: 10.0.h),
          SizedBox(
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: products.length,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 270.0.h,
                  crossAxisSpacing: 10.0.w),
              itemBuilder: (_, index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Product.routeName,
                        arguments: products[index].id,
                      );
                    },
                    child: ItemWidget(
                      product: products[index],
                      favoriteIcon: false,
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget makeSlider({required List<Banners> banner}) {
    return CarouselSlider.builder(
        unlimitedMode: true,
        autoSliderDelay: const Duration(seconds: 5),
        enableAutoSlider: true,
        slideBuilder: (index) {
          return CachedNetworkImage(
            imageUrl: banner[index].image!,
            color: const Color.fromRGBO(42, 3, 75, 0.35),
            colorBlendMode: BlendMode.srcOver,
            fit: BoxFit.fill,
            placeholder: (context, name) {
              return ShimmerEffect(
                borderRadius: 10.0.r,
                height: 88.h,
                width: 343.w,
              );
            },
            errorWidget: (context, error, child) {
              return ShimmerEffect(
                borderRadius: 10.0.r,
                height: 88.h,
                width: 343.w,
              );
            },
          );
        },
        slideTransform: const DefaultTransform(),
        slideIndicator: CircularSlideIndicator(
          currentIndicatorColor: AppColors.lightGrey,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 10.h, left: 20.0.w),
        ),
        itemCount: banner.length);
  }
}
