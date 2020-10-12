import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:alla24/colors.dart';
import 'package:alla24/provider/products.dart';
import 'package:alla24/shared/widgets/products_list.dart';
import 'package:provider/provider.dart';

class ProductDetailTabsBar extends StatefulWidget {
  final product;

  ProductDetailTabsBar(this.product);
  _ProductDetailTabsBarState createState() => _ProductDetailTabsBarState();
}

class _ProductDetailTabsBarState extends State<ProductDetailTabsBar>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.22,
      child: Card(
        child: DefaultTabController(
            length: 3,
            child: Scaffold(
                backgroundColor: Alla24Colors.white,
                appBar: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    indicatorWeight: 4.0,
                    indicatorColor: Colors.deepOrange,
                    unselectedLabelColor: Alla24Colors.black,
                    labelColor: Alla24Colors.button,
                    labelPadding: EdgeInsets.symmetric(horizontal: 30),
                    tabs: <Widget>[
                      Tab(
                          child: Text('الوصف',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center)),
                      Tab(
                          child: Text('مزيدمن المعلومات',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center)),
                      Tab(
                          child: Text('المراجعات',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center))
                    ]),
                body: TabBarView(controller: _tabController, children: <Widget>[
                  Text(widget.product.descreption,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center),
                  Text(widget.product.descreption,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center),
                  Text(widget.product.descreption,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center),
                ]))),
      ),
    );
  }
}
