import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_project/filter/filter_screen.dart';
import 'package:firebase_project/utils/common_widgets/circular_progress.dart';
import 'package:firebase_project/utils/common_widgets/custom_app_bar.dart';
import 'package:firebase_project/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'catalogue_controller.dart';

class CatalogueScreen extends StatefulWidget {
  static const String routeName = 'catalogue';
  final int categoryId;

  const CatalogueScreen({super.key, required this.categoryId});
  @override
  State<CatalogueScreen> createState() => _CatalogueScreenState();
}

class _CatalogueScreenState extends State<CatalogueScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      key: _key,
      appBar: _buildAppBar(context),
      body: Consumer(
        builder: (context, ref, child) {
          final catalouge = ref.watch(catalougeProvider(widget.categoryId));
          return catalouge.when(
            error: (error, stackTrace) => ErrorWidget(error),
            loading: () => CircularProgress(),
            data: (data) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                ),
                padding: EdgeInsets.all(8.0),
                itemCount: data!.categories!.length,
                itemBuilder: (context, index) {
                  final item = data.categories![index];
                  return GestureDetector(
                    onTap: () {
                      if (item.haschild!) {
                        Navigator.pushNamed(
                          context,
                          CatalogueScreen.routeName,
                          arguments: item.id,
                        );
                      } else {
                        
                      }
                    },
                    child: Container(
                      color: Colors.grey[100],
                      child: Column(
                        children: [
                          Expanded(
                            flex: 10,
                            child: Padding(
                              padding: EdgeInsets.only(top: 5.0, bottom: 5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4.0),
                                child: SizedBox(
                                  child: CachedNetworkImage(
                                    imageUrl: item.image!,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: EdgeInsets.all(2),
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: Text(
                                  item.name!,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  PreferredSize _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize:
          Size(double.infinity, MediaQuery.of(context).size.height * .20),
      child: CustomAppBar(
        scaffoldKey: _key,
        isHome: false,
        fixedHeight: 88.0,
        enableSearchField: false,
        leadingIcon: Icons.arrow_back,
        leadingOnTap: () {
          Navigator.pop(context);
        },
        trailingOnTap: () {
          Navigator.pushNamed(context, Filter.routeName);
        },
        title: 'Catalogue',
      ),
    );
  }
}
