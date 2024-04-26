import 'package:firebase_project/data/model/shipping_address_model.dart';
import 'package:firebase_project/screens/shipping/shipping_address_controller.dart';
import 'package:firebase_project/screens/shipping/shipping_create.dart';
import 'package:firebase_project/screens/shipping/shipping_update.dart';
import 'package:firebase_project/utils/common_widgets/circular_progress.dart';
import 'package:firebase_project/utils/common_widgets/custom_app_bar.dart';
import 'package:firebase_project/utils/common_widgets/dialog_components.dart';
import 'package:firebase_project/utils/constants/colors.dart';
import 'package:firebase_project/utils/constants/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ShippingAddress extends ConsumerStatefulWidget {
  final bool? fromCheckout;
  static const String routeName = 'shippingAddress';
  const ShippingAddress({
    super.key,
    this.fromCheckout = false,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ShippingAddressState();
}

class _ShippingAddressState extends ConsumerState<ShippingAddress> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        if (ref.read(shippingAddressProvider.notifier).currentPage <=
            ref.read(shippingAddressProvider.notifier).totalPage) {
          ref.read(shippingAddressProvider.notifier).getShippingAddress();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final shipping = ref.watch(shippingAddressProvider);
    return shipping.when(
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
        title: 'Shipping Address',
        fixedHeight: 88.0,
        enableSearchField: false,
        leadingIcon: Icons.arrow_back,
        leadingOnTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, List<Address> data) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
          child: _buildTitle(
              context, Icons.location_on_outlined, 'Shipping Address'),
        ),
        SizedBox(height: 20),
        Expanded(child: _buildAddress(context, data)),
      ],
    );
  }

  Widget _buildAddress(BuildContext context, List<Address> data) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: CustomScrollView(
        controller: controller,
        slivers: [
          SliverToBoxAdapter(
            child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) =>
                  _buildAddressCard(context, data[index]),
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 10,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(
    BuildContext context,
    IconData icon,
    String title,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: AppColors.primary,
            ),
            const SizedBox(width: 10.0),
            Text(
              title,
              style: FontStyles.montserratBold17().copyWith(fontSize: 19.0),
            ),
          ],
        ),
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, ShippingCreateScreen.routeName,
                  arguments: widget.fromCheckout);
            },
            icon: Icon(
              Icons.add_box_rounded,
              size: 30,
            ))
      ],
    );
  }

  Widget _buildAddressCard(BuildContext context, Address data) {
    return Slidable(
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          Visibility(
            visible: data.defaultAddress == 0 ? true : false,
            child: SlidableAction(
              onPressed: (context) async {
                AlertAction action = await DialogComponents.confirmDialog(
                    context, "Do you want remove this shipping address");

                if (action == AlertAction.ok) {
                  final shippingDelete = await ref
                      .watch(shippingAddressProvider.notifier)
                      .deleteAddress(addressId: data.id!);

                  if (shippingDelete['status'] == 200) {
                    ref.invalidate(shippingAddressProvider);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(shippingDelete['message']),
                      ),
                    );
                  }
                }
              },
              backgroundColor: Colors.red[300]!,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Remove',
              padding: EdgeInsets.zero,
            ),
          ),
          SlidableAction(
            onPressed: (context) async {
              Navigator.pushNamed(
                context,
                ShippingUpdateScreen.routeName,
                arguments: {
                  'id': data.id,
                  "from_checkout": widget.fromCheckout,
                },
              );
            },
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
            padding: EdgeInsets.zero,
          ),
        ],
      ),
      child: shippingTile(data, context),
    );
  }
}

Container shippingTile(Address data, BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
        color: AppColors.softGrey, borderRadius: BorderRadius.circular(10.0)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              data.name!,
              style: FontStyles.montserratBold17().copyWith(fontSize: 14.0),
            ),
            Visibility(
              visible: data.defaultAddress == 1 ? true : false,
              child: Container(
                padding: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.primary)),
                child: Text(
                  '✓ Default',
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(letterSpacing: .2),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 5.0),
        Text(
            '${data.address}, ${data.city}\n${data.state}, ${data.country}, ${data.pincode}')
      ],
    ),
  );
}
