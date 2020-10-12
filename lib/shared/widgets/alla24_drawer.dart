import 'package:alla24/colors.dart';
import 'package:flutter/material.dart';
import 'package:alla24/main/favorite/favorite_page.dart';
import 'package:alla24/main/shopping_cart/shopping_cart_page.dart';
import 'package:alla24/app_route.dart';

class Alla24Drawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(children: <Widget>[
      UserAccountsDrawerHeader(
          accountName: Text('Online shop'),
          currentAccountPicture: Row(
            children: [
              Expanded(
                child: Image.asset(
                  'assets/png/app_logo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Alla24Colors.button,
          )),
      InkWell(
          onTap: () => Navigator.pushNamed(context, AppRoute.mainRoute),
          child: ListTile(
              title: Text('القائمة الرئيسية'),
              leading: Icon(Icons.home, color: Colors.red))),
      InkWell(
          onTap: () => Navigator.pushNamed(context, AppRoute.ordersRoute),
          child: ListTile(
              title: Text('طلباتي'),
              leading: Icon(Icons.shopping_cart, color: Colors.red))),
      InkWell(
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => ShoppingCartPage())),
          child: ListTile(
              title: Text('السلة'),
              leading: Icon(
                Icons.shopping_cart,
                color: Colors.red,
              ))),
      InkWell(
          // onTap: () =>
          //     Navigator.pushReplacementNamed(context, AppRoute.ordersRoute),
          child: ListTile(
              title: Text('كل المنتجات'),
              leading: Icon(Icons.border_all, color: Colors.red))),
      InkWell(
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => FavoritePage())),
          child: ListTile(
              title: Text('المفضلة'),
              leading: Icon(Icons.favorite, color: Colors.red))),
      InkWell(
          onTap: () => Navigator.pushNamed(context, AppRoute.reversionRoute),
          child: ListTile(
              title: Text('الإسترجاع'),
              leading: Icon(Icons.assignment_returned))),
      InkWell(
          onTap: () => Navigator.pushNamed(context, AppRoute.profileRoute),
          child: ListTile(
              title: Text('تعديل الحساب'),
              leading: Icon(
                Icons.person,
              ))),
      InkWell(
          onTap: () =>
              Navigator.pushReplacementNamed(context, AppRoute.loginRoute),
          child: ListTile(
              title: Text('تسجيل الخروج'), leading: Icon(Icons.exit_to_app)))
    ]));
  }
}
