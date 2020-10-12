import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:alla24/colors.dart';
import 'package:alla24/provider/products.dart';
import 'package:alla24/shared/widgets/products_list.dart';
import 'package:provider/provider.dart';

class HuaweiTabsBar extends StatefulWidget {
  _HuaweiTabsBarState createState() => _HuaweiTabsBarState();
}

class _HuaweiTabsBarState extends State<HuaweiTabsBar>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.productsList;
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorWeight: 4.0,
                indicatorColor: Alla24Colors.button,
                unselectedLabelColor: Alla24Colors.black,
                labelColor: Alla24Colors.button,
                labelPadding: EdgeInsets.symmetric(horizontal: 30),
                tabs: <Widget>[
                  Tab(
                      child: Text('الأحدث',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center)),
                  Tab(
                      child: Text('الأكثر مبيعا',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center)),
                  Tab(
                      child: Text('جميع المنتجات',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center))
                ]),
            body: TabBarView(controller: _tabController, children: <Widget>[
              ProductsList(products),
              ProductsList(products),
              ProductsList(products),
            ])));
  }
}
