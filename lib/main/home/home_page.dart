import 'package:alla24/app_route.dart';
import 'package:alla24/shared/widgets/single_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alla24/colors.dart';
import 'package:alla24/main/home/home_page_controller.dart';
import 'package:alla24/provider/products.dart';
import 'package:alla24/shared/widgets/closable.dart';
import 'package:alla24/shared/widgets/loader.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  HomePageController _controller = HomePageController();
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    Future<void>.delayed(Duration(milliseconds: 1000), () async {});
    // _controller.sliderHomePage();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.productsList;
    super.build(context);
    return Scaffold(
      appBar: _buildFullAppBar(),
      body: Observer(
          builder: (_) => SafeArea(
              top: true,
              bottom: true,
              left: false,
              right: false,
              child: Stack(children: [
                Container(
                    height: double.infinity,
                    padding: EdgeInsets.all(10),
                    child: SingleChildScrollView(
                        child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        _buildSliderCarousel(),
                                        SizedBox(height: 12),
                                        _buildCategoryHorizentalList(),
                                        _buildLastProductList(products),
                                        SizedBox(height: 12),
                                        _buildTodayProductList(products),
                                        SizedBox(height: 12),
                                        _buildNewProductList(products),
                                        SizedBox(height: 12),
                                        _buildNewProductList(products),
                                      ])
                                ])))),
                Visibility(
                    visible: _controller.loading,
                    child: Center(child: Loader()))
              ]))),
    );
  }

  _buildSearchField() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5),
        child: Row(children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                    controller: _searchController,
                    onChanged: (value) {},
                    onSubmitted: (value) {
                      KeyBoard.close(context);
                      /*todo handle search*/
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        prefixIcon: Icon(
                          EvaIcons.search,
                          color: Colors.white,
                        ),
                        hintText: "search",
                        hintStyle: TextStyle(color: Colors.blueGrey))),
              ))
        ]));
  }

  _buildFullAppBar() {
    return AppBar(
        backgroundColor: Alla24Colors.button,
        leading: IconButton(
          icon: Icon(
            EvaIcons.menu,
            color: Alla24Colors.white,
          ),
          onPressed: () {},
        ),
        title: _buildSearchField(),
        actions: [
          IconButton(
            icon: Icon(
              Icons.filter_list,
              color: Alla24Colors.white,
            ),
            onPressed: () {},
          )
        ]);
  }

  _buildSliderCarousel() {
    return GestureDetector(
      onTap: () {},
      child: Stack(children: [
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.27,
            width: double.infinity,
            child: Carousel(
              images: [
                ExactAssetImage("assets/png/temp_news.png"),
                ExactAssetImage("assets/png/temp_news.png"),
              ],
              // images: _controller.sliderData
              //     .map((slider) => GestureDetector(
              //         onTap: () => Navigator.of(context).pushNamed(
              //             AppRoute.musicPlayerRoute,
              //             arguments: slider),
              //         child: slider.contents?.avatar1 != null
              //             ? CachedNetworkImage(
              //                 imageUrl:
              //                     "${SocialMedia.urlPrefix + slider.contents.avatar1}")
              //             : AssetImage("assets/png/temp_news.png")
              // CachedNetworkImage(
              //     imageUrl:
              //     'https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
              // ExactAssetImage("assets/page_design/home_page.jpeg"),
              // ))
              // .toList(),
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotColor: Colors.deepOrange,
              dotPosition: DotPosition.bottomCenter,
              indicatorBgPadding: 5.0,
              borderRadius: true,
              moveIndicatorFromBottom: 180.0,
              noRadiusForIndicator: true,
            )),
        Positioned(
            right: 10,
            top: 50,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'عرض الملابس الرياضية',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'اقوى العروض على احدث الملابس',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
              RaisedButton(
                color: Alla24Colors.sliderButton,
                onPressed: () {},
                padding: const EdgeInsets.symmetric(vertical: 5),
                textColor: Alla24Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Text('احصل عليه'),
              )
            ]))
      ]),
    );
  }

  _buildCategoryHorizentalList() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.12,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (ctx, index) => InkWell(
              onTap: () {},
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Alla24Colors.button,
                        child: Icon(EvaIcons.phone),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Text("هواتف ذكية",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12)))
                    ],
                  ))),
        ));
  }

  _buildLastProductList(List<Product> products) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("اخر المنتجات", style: TextStyle(color: Alla24Colors.black)),
            Text("رؤية الكل", style: TextStyle(color: Alla24Colors.button))
          ]),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (ctx, index) => Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: ChangeNotifierProvider.value(
                        value: products[index], child: SingleProduct()))),
          )
        ]));
  }

  _buildTodayProductList(List<Product> products) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("صفقة اليوم", style: TextStyle(color: Alla24Colors.black)),
            Text("رؤية الكل", style: TextStyle(color: Alla24Colors.button))
          ]),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (ctx, index) => Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: ChangeNotifierProvider.value(
                        value: products[index], child: SingleProduct()))),
          )
        ]));
  }

  _buildNewProductList(List<Product> products) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("احدث المنتجات", style: TextStyle(color: Alla24Colors.black)),
            Text("رؤية الكل", style: TextStyle(color: Alla24Colors.button))
          ]),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (ctx, index) => Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: ChangeNotifierProvider.value(
                        value: products[index], child: SingleProduct()))),
          )
        ]));
  }
}
