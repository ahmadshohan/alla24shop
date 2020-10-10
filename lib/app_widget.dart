import 'package:alla24/account/forgot_password/forget_password_page.dart';
import 'package:alla24/account/login/login_page.dart';
import 'package:alla24/account/register/register_page.dart';
import 'package:alla24/app_route.dart';
import 'package:alla24/colors.dart';
import 'package:alla24/main/settings/orders/orders_page.dart';
import 'package:alla24/main/settings/profile/edit_profile/edit_profile_page.dart';
import 'package:alla24/main/settings/profile/profile_page.dart';
import 'package:alla24/main/shopping_cart/shopping_cart_page.dart';
import 'package:alla24/provider/orders.dart';
import 'package:alla24/reversion/reversion_page.dart';
import 'package:alla24/shared/localization/app_localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:alla24/main/main_navigator.dart';
import 'package:alla24/product/product_detail/product_details_page.dart';
import 'package:alla24/provider/products.dart';
import 'package:alla24/splash/splash_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Alla24App extends StatefulWidget {
  @override
  Alla24AppState createState() => Alla24AppState();
}

class Alla24AppState extends State<Alla24App> {
  final _fontFamily = 'poppins';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Alla24Colors.navigationBar,
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Products()),
        ChangeNotifierProvider(create: (ctx) => Orders()),
      ],
      child: MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'Alla24',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: Alla24Colors.button,
              canvasColor: Alla24Colors.bg,
              appBarTheme: Theme.of(context).appBarTheme.copyWith(
                  color: Alla24Colors.playerGradientLow,
                  iconTheme: IconThemeData(color: Colors.white)),
              fontFamily: _fontFamily),
          initialRoute: AppRoute.splashRoute,
          routes: {
            AppRoute.splashRoute: (ctx) => SplashPage(),
            AppRoute.registerRoute: (ctx) => RegisterPage(),
            AppRoute.loginRoute: (ctx) => LoginPage(),
            AppRoute.forgotPasswordRoute: (ctx) => ForgotPasswordPage(),
            AppRoute.mainRoute: (ctx) => MainNavigator(),
            AppRoute.productDetailRoute: (ctx) => ProductDetails(),
            AppRoute.profileRoute: (ctx) => ProfilePage(),
            AppRoute.editProfileRoute: (ctx) => EditProfilePage(),
            AppRoute.reversionRoute: (ctx) => ReversionPage(),
            AppRoute.shoppingCartRoute: (ctx) => ShoppingCartPage(),
            AppRoute.ordersRoute: (ctx) => OrdersPage(),
          }),
    );
  }

  static void setLang(BuildContext context, String lang) async {
    AppLocalization.setLang(context, lang);
    Alla24AppState state = context.findAncestorStateOfType<Alla24AppState>();
    state.setState(() {});
  }
}
