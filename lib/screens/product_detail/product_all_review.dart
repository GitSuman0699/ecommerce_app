import 'package:firebase_project/screens/product_detail/product_detail.dart';
import 'package:firebase_project/screens/product_detail/product_controller.dart';
import 'package:firebase_project/utils/common_widgets/circular_progress.dart';
import 'package:firebase_project/utils/common_widgets/custom_app_bar.dart';
import 'package:firebase_project/utils/common_widgets/pagination_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllReviewScreen extends ConsumerStatefulWidget {
  final int productId;
  static const String routeName = "allReview";
  const AllReviewScreen({
    super.key,
    required this.productId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AllReviewScreenState();
}

class _AllReviewScreenState extends ConsumerState<AllReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Consumer(
        builder: (context, ref, child) {
          final review = ref.watch(reviewProvider(widget.productId));
          return review.when(
            error: (error, stackTrace) => ErrorWidget(error),
            loading: () => CircularProgress(),
            data: (data) => CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: reviewListBuilder(review: data),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Visibility(
                    visible: ref
                                .read(reviewProvider(widget.productId).notifier)
                                .currentPage <=
                            ref
                                .read(reviewProvider(widget.productId).notifier)
                                .totalPage &&
                        data.isNotEmpty,
                    child: PaginationLoader(),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  PreferredSize _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize:
          Size(double.infinity, MediaQuery.of(context).size.height * .20),
      child: CustomAppBar(
        isHome: false,
        title: 'All Reviews',
        fixedHeight: 88.0,
        enableSearchField: false,
        leadingIcon: Icons.arrow_back,
        leadingOnTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
