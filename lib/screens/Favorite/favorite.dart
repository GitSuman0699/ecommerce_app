import 'package:firebase_project/screens/Favorite/favorite_controller.dart';
import 'package:firebase_project/screens/Product/product.dart';
import 'package:firebase_project/data/model/favorite_model.dart';
import 'package:firebase_project/utils/common_widgets/circular_progress.dart';
import 'package:firebase_project/utils/common_widgets/custom_app_bar.dart';
import 'package:firebase_project/utils/common_widgets/item_widget.dart';
import 'package:firebase_project/utils/constants/colors.dart';
import 'package:firebase_project/utils/constants/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Favorite extends ConsumerStatefulWidget {
  static const String routeName = 'favorite';
  const Favorite({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FavoriteState();
}

class _FavoriteState extends ConsumerState<Favorite> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        if (ref.read(favoriteProvider.notifier).currentPage <=
            ref.read(favoriteProvider.notifier).totalPage) {
          ref.read(favoriteProvider.notifier).getFavorite();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: _buildAppBar(context),
        body: Consumer(
          builder: (context, ref, child) {
            final wishlist = ref.watch(favoriteProvider);
            return wishlist.when(
              error: (error, stackTrace) => ErrorWidget(error),
              loading: () => Center(
                child: CircularProgressIndicator(),
              ),
              data: (data) => _buildBody(context, data, controller),
            );
          },
        ));
  }

  PreferredSize _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize:
          Size(double.infinity, MediaQuery.of(context).size.height * .20),
      child: CustomAppBar(
        isHome: false,
        title: 'Favorite',
        fixedHeight: 88.0.h,
        enableSearchField: false,
        // leadingIcon: Icons.arrow_back,
        leadingOnTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _buildBody(
      BuildContext context, List<Wishlist> data, ScrollController controller) {
    return CustomScrollView(
      controller: controller,
      slivers: [
        SliverToBoxAdapter(
          child: _buildItemAndSortTile(context, data),
        ),
        SliverToBoxAdapter(
          child: _buildFavoriteItems(context, data),
        ),
        SliverToBoxAdapter(
          child: Visibility(
              visible: ref.read(favoriteProvider.notifier).currentPage <=
                      ref.read(favoriteProvider.notifier).totalPage &&
                  data.isNotEmpty,
              child: CircularProgress()),
        )
      ],
    );
  }

  Widget _buildItemAndSortTile(BuildContext context, List<Wishlist> data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          '${data.length} Items',
          style: FontStyles.montserratBold19(),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Sort by:',
              style: FontStyles.montserratBold12()
                  .copyWith(color: AppColors.textSecondary),
            ),
            Text(
              'Price:Lowest to high',
              style: FontStyles.montserratBold12()
                  .copyWith(color: AppColors.primary),
            ),
            const Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.primary,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteItems(BuildContext context, List<Wishlist> data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 260.0.w,
          crossAxisSpacing: 10.0.h,
        ),
        itemBuilder: (_, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Product.routeName,
                  arguments: data[index].productId);
            },
            child: ItemWidget(
              wishlist: data[index],
              // index: index,
              favoriteIcon: true,
            ),
          );
        },
      ),
    );
  }
}
