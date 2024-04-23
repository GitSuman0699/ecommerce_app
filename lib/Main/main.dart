import 'package:firebase_project/screens/orders/order.dart';
import 'package:firebase_project/screens/cart/cart.dart';
import 'package:firebase_project/screens/cart/cart_controller.dart';
import 'package:firebase_project/screens/catalogue/catalogue.dart';
import 'package:firebase_project/screens/Favorite/favorite.dart';
import 'package:firebase_project/screens/Profile/profile.dart';
import 'package:firebase_project/data/model/cart_model.dart';
import 'package:firebase_project/screens/home/home_screen.dart';
import 'package:firebase_project/utils/common_widgets/circular_progress.dart';
import 'package:firebase_project/utils/constants/colors.dart';
import 'package:firebase_project/utils/constants/font_styles.dart';
import 'package:firebase_project/utils/constants/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Main extends ConsumerStatefulWidget {
  const Main({super.key});
  static const String routeName = 'main';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainState();
}

class _MainState extends ConsumerState<Main> {
  int currentIndex = 0;
  List<Widget> myScreens = [
    const HomeScreen(),
    const OrderScreen(),
    const Favorite(),
    const Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    return cart.when(
      error: (error, stackTrace) => ErrorWidget(error),
      loading: () => CircularProgress(),
      data: (data) => Scaffold(
        body: myScreens.elementAt(currentIndex),
        // bottomNavigationBar: buildBottomNavigation(),
        bottomSheet: buildBottomSheet(data),
        resizeToAvoidBottomInset: false,
      ),
    );
  }

  Widget buildBottomNavigation() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(
            icon: Image(
              image: AssetImage(
                'assets/bottomBarIcons/home 1.png',
              ),
            ),
            label: 'Home',
            tooltip: 'Home'),
        BottomNavigationBarItem(
            icon: Image(
              image: AssetImage(
                'assets/bottomBarIcons/view-grid 3.png',
              ),
            ),
            label: 'Orders',
            tooltip: 'Orders'),
        BottomNavigationBarItem(
            icon: Image(
              image: AssetImage(
                'assets/bottomBarIcons/heart 2.png',
              ),
            ),
            label: 'Favorite',
            tooltip: 'Favorite'),
        BottomNavigationBarItem(
            icon: Image(
              image: AssetImage(
                'assets/bottomBarIcons/user 2.png',
              ),
            ),
            label: 'Profile',
            tooltip: 'Profile'),
      ],
      selectedItemColor: AppColors.primary,
      onTap: (value) {
        setState(() {
          // currentIndex = value;
        });
      },
    );
  }

  Widget buildBottomSheet(CartModel data) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 50.0,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 1,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            currentIndex = 0;
                          });
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.home,
                              color: currentIndex == 0
                                  ? AppColors.primary
                                  : Colors.grey,
                            ),
                            Text(
                              'Home',
                              style: TextStyle(
                                color: currentIndex == 0
                                    ? Colors.black
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            currentIndex = 1;
                          });
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.category,
                              color: currentIndex == 1
                                  ? AppColors.primary
                                  : Colors.grey,
                            ),
                            Text(
                              'Orders',
                              style: TextStyle(
                                color: currentIndex == 1
                                    ? Colors.black
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            currentIndex = 2;
                          });
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.favorite_outline,
                              color: currentIndex == 2
                                  ? AppColors.primary
                                  : Colors.grey,
                            ),
                            Text(
                              'Favorite',
                              style: TextStyle(
                                color: currentIndex == 2
                                    ? Colors.black
                                    : AppColors.textSecondary,
                              ),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            currentIndex = 3;
                          });
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.person_outline,
                              color: currentIndex == 3
                                  ? AppColors.primary
                                  : Colors.grey,
                            ),
                            Text(
                              'Profile',
                              style: TextStyle(
                                color: currentIndex == 3
                                    ? Colors.black
                                    : AppColors.textSecondary,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: screenWidth * .3,
              ),
            ],
          ),
          Positioned(
            right: 0.0,
            bottom: 15.0,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Cart.routeName);
              },
              child: Container(
                width: 116.0,
                height: 56,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.primary],
                    end: Alignment.bottomLeft,
                    begin: Alignment.topRight,
                    stops: [0, 1],
                  ),
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                  ),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.only(left: 10.0),
                  minLeadingWidth: 10.0,
                  leading: const Icon(
                    Icons.shopping_cart,
                    color: AppColors.white,
                    size: 21.0,
                  ),
                  title: RichText(
                    text: TextSpan(
                      text: '${indianRupee(data.totalAmount.toString())}\n',
                      style: FontStyles.montserratBold17()
                          .copyWith(fontSize: 11.0, color: AppColors.white),
                      children: [
                        TextSpan(
                          text: '${data.totalQuanity} Items',
                          style: FontStyles.montserratRegular14()
                              .copyWith(fontSize: 11.0, color: AppColors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}




// class Main extends StatefulWidget {
//   const Main({super.key});
//   static const String routeName = 'main';

//   @override
//   MainState createState() => MainState();
// }

// class MainState extends State<Main> {
//   int currentIndex = 0;
//   List<Widget> myScreens = [
//     const HomeScreen(),
//     const OrderScreen(),
//     const Favorite(),
//     const Profile(),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: myScreens.elementAt(currentIndex),
//       // bottomNavigationBar: buildBottomNavigation(),
//       bottomSheet: buildBottomSheet(),
//       resizeToAvoidBottomInset: false,
//     );
//   }

//   Widget buildBottomNavigation() {
//     return BottomNavigationBar(
//       currentIndex: currentIndex,
//       items: const [
//         BottomNavigationBarItem(
//             icon: Image(
//               image: AssetImage(
//                 'assets/bottomBarIcons/home 1.png',
//               ),
//             ),
//             label: 'Home',
//             tooltip: 'Home'),
//         BottomNavigationBarItem(
//             icon: Image(
//               image: AssetImage(
//                 'assets/bottomBarIcons/view-grid 3.png',
//               ),
//             ),
//             label: 'Orders',
//             tooltip: 'Orders'),
//         BottomNavigationBarItem(
//             icon: Image(
//               image: AssetImage(
//                 'assets/bottomBarIcons/heart 2.png',
//               ),
//             ),
//             label: 'Favorite',
//             tooltip: 'Favorite'),
//         BottomNavigationBarItem(
//             icon: Image(
//               image: AssetImage(
//                 'assets/bottomBarIcons/user 2.png',
//               ),
//             ),
//             label: 'Profile',
//             tooltip: 'Profile'),
//       ],
//       selectedItemColor: AppColors.primary,
//       onTap: (value) {
//         setState(() {
//           // currentIndex = value;
//         });
//       },
//     );
//   }

//   Widget buildBottomSheet() {
//     var screenWidth = MediaQuery.of(context).size.width;
//     return Container(
//       height: 50.0,
//       margin: const EdgeInsets.symmetric(vertical: 10.0),
//       child: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 10.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const SizedBox(
//                         width: 1,
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             currentIndex = 0;
//                           });
//                         },
//                         child: Column(
//                           children: [
//                             Icon(
//                               Icons.home,
//                               color: currentIndex == 0
//                                   ? AppColors.primary
//                                   : Colors.grey,
//                             ),
//                             Text(
//                               'Home',
//                               style: TextStyle(
//                                 color: currentIndex == 0
//                                     ? Colors.black
//                                     : AppColors.textSecondary,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             currentIndex = 1;
//                           });
//                         },
//                         child: Column(
//                           children: [
//                             Icon(
//                               Icons.category,
//                               color: currentIndex == 1
//                                   ? AppColors.primary
//                                   : Colors.grey,
//                             ),
//                             Text(
//                               'Orders',
//                               style: TextStyle(
//                                 color: currentIndex == 1
//                                     ? Colors.black
//                                     : AppColors.textSecondary,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             currentIndex = 2;
//                           });
//                         },
//                         child: Column(
//                           children: [
//                             Icon(
//                               Icons.favorite_outline,
//                               color: currentIndex == 2
//                                   ? AppColors.primary
//                                   : Colors.grey,
//                             ),
//                             Text(
//                               'Favorite',
//                               style: TextStyle(
//                                 color: currentIndex == 2
//                                     ? Colors.black
//                                     : AppColors.textSecondary,
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             currentIndex = 3;
//                           });
//                         },
//                         child: Column(
//                           children: [
//                             Icon(
//                               Icons.person_outline,
//                               color: currentIndex == 3
//                                   ? AppColors.primary
//                                   : Colors.grey,
//                             ),
//                             Text(
//                               'Profile',
//                               style: TextStyle(
//                                 color: currentIndex == 3
//                                     ? Colors.black
//                                     : AppColors.textSecondary,
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 width: screenWidth * .3,
//               ),
//             ],
//           ),
//           Positioned(
//             right: 0.0,
//             bottom: 15.0,
//             child: GestureDetector(
//               onTap: () {
//                 Navigator.pushNamed(context, Cart.routeName);
//               },
//               child: Container(
//                 width: 116.0,
//                 height: 56,
//                 decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [AppColors.primary, AppColors.primary],
//                     end: Alignment.bottomLeft,
//                     begin: Alignment.topRight,
//                     stops: [0, 1],
//                   ),
//                   color: AppColors.primary,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(30.0),
//                     bottomLeft: Radius.circular(30.0),
//                   ),
//                 ),
//                 child: ListTile(
//                   contentPadding: const EdgeInsets.only(left: 10.0),
//                   minLeadingWidth: 10.0,
//                   leading: const Icon(
//                     Icons.shopping_cart,
//                     color: AppColors.white,
//                     size: 21.0,
//                   ),
//                   title: RichText(
//                     text: TextSpan(
//                       text: '\$239.98\n',
//                       style: FontStyles.montserratBold17()
//                           .copyWith(fontSize: 11.0, color: AppColors.white),
//                       children: [
//                         TextSpan(
//                           text: '2 Items',
//                           style: FontStyles.montserratRegular14()
//                               .copyWith(fontSize: 11.0, color: AppColors.white),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
