import 'package:alla24/shared/widgets/j_raised_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:provider/provider.dart';
import 'package:alla24/product/product_detail/product_detail_controller.dart';
import 'package:alla24/shared/constant/data_list.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:alla24/colors.dart';
import 'package:alla24/shared/widgets/single_product_vertical.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:alla24/provider/products.dart';

class ProductDetails extends StatefulWidget {
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  ProductDetailController _controller = ProductDetailController();
  @override
  void initState() {
    super.initState();
    _controller.init(context);
  }

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final productsData = Provider.of<Products>(context);
    final loadedProduct = productsData.findById(productId);
    final productCategory = loadedProduct.category;
    final productList = productsData.productsList;
    final productsFilterd = productList.where((product) {
      return product.category.contains(productCategory);
    }).toList();

    return Scaffold(
        body: Observer(
            builder: (_) => SafeArea(
                top: true,
                bottom: false,
                right: false,
                left: false,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomScrollView(slivers: <Widget>[
                    _sliverProductPhotosBar(loadedProduct),
                    SliverList(
                        delegate: SliverChildListDelegate([
                      _huaweiTextAvatar(),
                      _buildSingleProductWithoutPicture(loadedProduct),
                      _buildSizeDropDownButton(),
                      _buildQuantityDropDownButton(),
                      _moreProductRelated(productsFilterd)
                    ]))
                  ]),
                ))),
        bottomNavigationBar: _bottomBuyAddButtons(productsData, loadedProduct));
  }

  _sliverProductPhotosBar(Product loadedProduct) {
    return SliverAppBar(
        backgroundColor: Alla24Colors.cardItemBg,
        snap: true,
        floating: true,
        automaticallyImplyLeading: false,
        expandedHeight: MediaQuery.of(context).size.height * 0.3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        flexibleSpace: FlexibleSpaceBar(
            background: ClipRRect(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
                child: Card(
                    color: Alla24Colors.cardItemBg,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                          icon: Icon(
                                            EvaIcons.arrowForward,
                                          ),
                                          onPressed: () =>
                                              Navigator.pop(context)),
                                      IconButton(
                                        icon: Icon(EvaIcons.share),
                                        onPressed: () async {
                                          await FlutterShare.share(
                                            title: loadedProduct.name ?? '',
                                            text:
                                                loadedProduct.descreption ?? '',
                                            // linkUrl:
                                            // "https://s3.amazonaws.com/scifri-segments/scifri201711241.mp3"
                                            // linkUrl:
                                            //     'http://api-ahmat.thismusic.com.tr/${songItem?.file}'
                                          );
                                        },
                                      )
                                    ]),
                                IconButton(
                                    icon: Icon(
                                        loadedProduct.isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: loadedProduct.isFavorite
                                            ? Colors.red
                                            : Colors.black),
                                    onPressed: () =>
                                        loadedProduct.toggleFavoriteStatus()),
                                Expanded(
                                    child: Row(children: [
                                  Expanded(
                                      child: Image.asset(
                                    loadedProduct.image,
                                    fit: BoxFit.contain,
                                  ))
                                ]))
                              ])),
                        ])))));
  }

  _huaweiTextAvatar() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Row(children: [
          CircleAvatar(
              radius: 40,
              backgroundColor: Colors.black12,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset('assets/png/avatar.png',
                    width: 100, height: 100, fit: BoxFit.cover),
              )),
          SizedBox(width: 10),
          Text('HUAWEI')
        ]));
  }

  _buildSingleProductWithoutPicture(Product loadedProduct) {
    return Card(
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide.none),
        child: Column(children: [
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    flex: 2,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('حقيبة ظهر',
                                        textAlign: TextAlign.right,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF3C3C3C))),
                                    Row(children: [
                                      Icon(EvaIcons.star, color: Colors.amber),
                                      Icon(EvaIcons.star, color: Colors.amber),
                                      Icon(EvaIcons.star, color: Colors.amber),
                                      Icon(EvaIcons.star, color: Colors.amber),
                                      Icon(EvaIcons.star, color: Colors.amber)
                                    ])
                                  ]),
                              Row(children: [
                                Expanded(
                                    child: Text(
                                        "${loadedProduct.currentPrice.toString()} دع",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Alla24Colors.button))),
                                Expanded(
                                    child: Text(
                                  " ${loadedProduct.oldPrice.toString()}دع",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 9,
                                      decoration: TextDecoration.lineThrough),
                                )),
                                Spacer(),
                                Expanded(
                                    flex: 1,
                                    child: Text('خصم %8',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Alla24Colors.button)))
                              ])
                            ])))
              ])
        ]));
  }

  _moreProductRelated(List<Product> productsFilterd) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('مزيد من المنتجات ذات الصلة',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.bold)),
      Container(
          height: MediaQuery.of(context).size.height * 0.35,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: productsFilterd.length,
              itemBuilder: (ctx, index) => Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: ChangeNotifierProvider.value(
                      value: productsFilterd[index],
                      child: SingleProductVertical()))))
    ]);
  }

  _buildSizeDropDownButton() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String size in sizeList) {
      var newItem = DropdownMenuItem(
          child: Text(size, overflow: TextOverflow.ellipsis), value: size);
      dropDownItems.add(newItem);
    }
    return Card(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: DropdownButton<String>(
                isExpanded: true,
                hint: Text('المقاس', style: TextStyle(color: Colors.black)),
                onChanged: (selectedSize) {
                  _controller.selectedSize(selectedSize);
                },
                value: _controller.size,
                items: dropDownItems)));
  }

  _buildQuantityDropDownButton() {
    List<DropdownMenuItem<int>> dropDownItems = [];
    for (int quantity in quantityList) {
      var newItem = DropdownMenuItem(
          child: Text('$quantity', overflow: TextOverflow.ellipsis),
          value: quantity);
      dropDownItems.add(newItem);
    }
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Card(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: DropdownButton<int>(
                  isExpanded: true,
                  elevation: 7,
                  hint: Text('الكمية'),
                  onChanged: (selectedQuantity) {
                    _controller.selectedQuantity(selectedQuantity);
                  },
                  value: _controller.quantity,
                  items: dropDownItems)),
        ));
  }

  _bottomBuyAddButtons(Products productsData, Product loadedProduct) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        color: Colors.white30,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Divider(),
          Row(children: <Widget>[
            Expanded(
                child: JRaisedButton(
                    text: 'اشتري الآن',
                    onPressed: () {
                      _controller.handleOrderNow(context);
                    })),
            SizedBox(width: 15),
            Expanded(
                child: JRaisedButton(
                    text: 'إضافة الى السلة',
                    onPressed: () async {
                      productsData.addCart(
                        productId: loadedProduct.id,
                        title: loadedProduct.name,
                        quantity: _controller.quantity,
                        currentPrice: loadedProduct.currentPrice,
                        oldPrice: loadedProduct.oldPrice,
                        isFavorite: loadedProduct.isFavorite,
                        image: loadedProduct.image,
                        size: _controller.size,
                      );
                    }))
          ])
        ]));
  }
}
