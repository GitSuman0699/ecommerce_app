import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_project/screens/order_detail/order_detail_screen.dart';
import 'package:firebase_project/screens/orders/order_controller.dart';
import 'package:firebase_project/data/model/order_list_model.dart';
import 'package:firebase_project/utils/common_widgets/circular_progress.dart';
import 'package:firebase_project/utils/common_widgets/custom_app_bar.dart';
import 'package:firebase_project/utils/common_widgets/item_widget.dart';
import 'package:firebase_project/utils/constants/colors.dart';
import 'package:firebase_project/utils/constants/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderScreen extends ConsumerStatefulWidget {
  static const String routeName = 'orders';
  const OrderScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrderScreenState();
}

class _OrderScreenState extends ConsumerState<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    final orderList = ref.watch(orderListProvider);
    return orderList.when(
      error: (error, stackTrace) => ErrorWidget(error),
      loading: () => CircularProgress(),
      data: (data) => Scaffold(
        backgroundColor: AppColors.white,
        appBar: _buildAppBar(context),
        body: _buildBody(context, data),
      ),
    );
  }

  PreferredSize _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize:
          Size(double.infinity, MediaQuery.of(context).size.height * .20),
      child: CustomAppBar(
        isHome: false,
        title: 'My Orders',
        fixedHeight: 88.0,
        enableSearchField: false,
        // leadingIcon: Icons.arrow_back,
        leadingOnTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, OrderListModel? data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListView.builder(
          itemCount: data!.orders!.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, OrderDetailScreen.routeName);
                },
                child: _buildOrdersCard(data.orders![index]));
          }),
    );
  }

  Widget _buildOrdersCard(Orders orders) {
    return Card(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: AppColors.lightGrey),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ID# ${orders.orderNumber}',
              style: FontStyles.montserratBold17().copyWith(fontSize: 20.0),
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Price ${orders.price}',
                  style: FontStyles.montserratBold17().copyWith(fontSize: 14.0),
                ),
                Text(
                  orders.createdAt!,
                  style: FontStyles.montserratBold17().copyWith(fontSize: 14.0),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            _buildOrderItemsList(context, orders),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItemsList(BuildContext context, Orders orders) {
    return SizedBox(
      height: 50.h,
      child: Row(
        children: [
          CachedNetworkImage(
            height: 80,
            width: 80,
            imageUrl: orders.image!,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    orders.title!,
                    maxLines: 2,
                    style:
                        FontStyles.montserratBold17().copyWith(fontSize: 14.0),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text("Order Status: ${orders.status!.toUpperCase()}",
                      style: FontStyles.montserratBold17()
                          .copyWith(fontSize: 12.0))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
