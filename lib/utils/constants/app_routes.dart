import 'package:firebase_project/screens/cart/cart.dart';
import 'package:firebase_project/screens/catalogue/catalogue.dart';
import 'package:firebase_project/screens/CheckOut/check_out.dart';
import 'package:firebase_project/screens/Favorite/favorite.dart';
import 'package:firebase_project/Filter/filter.dart';
import 'package:firebase_project/screens/Items/items.dart';
import 'package:firebase_project/Main/main.dart';
import 'package:firebase_project/screens/Notifications/notifications.dart';
import 'package:firebase_project/screens/order_detail/order_detail_screen.dart';
import 'package:firebase_project/screens/orders/order.dart';
import 'package:firebase_project/screens/PrivacyPolicy/privacy_policy.dart';
import 'package:firebase_project/screens/Product/product.dart';
import 'package:firebase_project/screens/Profile/profile.dart';
import 'package:firebase_project/screens/Settings/settings.dart';
import 'package:firebase_project/screens/ShippingAddress/shipping_address.dart';
import 'package:firebase_project/screens/SignUp/sign_up.dart';
import 'package:firebase_project/screens/home/home_screen.dart';
import 'package:firebase_project/screens/login/phone_screen.dart';
import 'package:firebase_project/screens/login/verification_screen.dart';
import 'package:firebase_project/screens/on_boarding/on_boarding_screen.dart';
import 'package:firebase_project/screens/splash/splash_screen.dart';
import 'package:firebase_project/utils/local_storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
        settings: settings,
        builder: (_) {
          switch (settings.name) {
            case '/':
              return const OnBoarding();
            case SplashScreen.routeName:
              return const SplashScreen();
            case Login.routeName:
              return const Login();
            case Verification.routeName:
              return const Verification();
            case HomeScreen.routeName:
              return const HomeScreen();
            case Main.routeName:
              return const Main();
            case Catalogue.routeName:
              return const Catalogue();
            case Items.routeName:
              return const Items();
            case Filter.routeName:
              return const Filter();
            case Product.routeName:
              return Product(productId: settings.arguments as int);
            case Favorite.routeName:
              return const Favorite();
            case Profile.routeName:
              return const Profile();
            case Cart.routeName:
              return const Cart();
            case CheckOut.routeName:
              return const CheckOut();
            case SignUp.routeName:
              return const SignUp();
            case Settings.routeName:
              return const Settings();
            case OrderScreen.routeName:
              return const OrderScreen();
            case OrderDetailScreen.routeName:
              return const OrderDetailScreen();
            case NotificationScreen.routeName:
              return const NotificationScreen();
            case PrivacyPolicy.routeName:
              return const PrivacyPolicy();
            case ShippingAddress.routeName:
              return const ShippingAddress();
            case OnBoarding.routeName:
              return const OnBoarding();

            default:
              return const OnBoarding();
          }
        });
  }

  // static Map<String, Widget Function(dynamic)> appRoutes = {
  //   '/': (_) => const OnBoarding(),
  //   SplashScreen.routeName: (_) => const SplashScreen(),
  //   Login.routeName: (_) => const Login(),
  //   Verification.routeName: (_) => const Verification(),
  //   HomeScreen.routeName: (_) => const HomeScreen(),
  //   Main.routeName: (_) => const Main(),
  //   Catalogue.routeName: (_) => const Catalogue(),
  //   Items.routeName: (_) => const Items(),
  //   Filter.routeName: (_) => const Filter(),
  //   Product.routeName: (_) => Product(
  //         productId: ModalRoute.of(context)!.settings.arguments as int,
  //       ),
  //   Favorite.routeName: (_) => const Favorite(),
  //   Profile.routeName: (_) => const Profile(),
  //   Cart.routeName: (_) => const Cart(),
  //   CheckOut.routeName: (_) => const CheckOut(),
  //   SignUp.routeName: (_) => const SignUp(),
  //   Settings.routeName: (_) => const Settings(),
  //   Orders.routeName: (_) => const Orders(),
  //   PrivacyPolicy.routeName: (_) => const PrivacyPolicy(),
  //   OnBoarding.routeName: (_) => const OnBoarding(),
  //   NotificationScreen.routeName: (_) => const NotificationScreen(),
  //   ShippingAddress.routeName: (_) => const ShippingAddress(),
  // };

  static setSystemStyling() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light,
    );
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
  }

  static const privacyPolicyTxt =
      'Give your E-Commerce app an outstanding look.It\'s a small but attractive and beautiful design template for your E-Commerce App.Contact us for more amazing and outstanding designs for your apps.Do share this app with your Friends and rate us if you like this.Also check your other apps';
}
