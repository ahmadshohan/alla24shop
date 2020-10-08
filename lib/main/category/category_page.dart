import 'package:alla24/colors.dart';
import 'package:alla24/provider/products.dart';
import 'package:alla24/shared/widgets/closable.dart';
import 'package:alla24/shared/widgets/products_grid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final _searchController = TextEditingController();
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.productsList;
    return Scaffold(
      appBar: _buildFullAppBar(),
      body: Container(
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(children: [
                    Text("احدث العروض",
                        style: TextStyle(
                            color: Alla24Colors.button, fontSize: 19)),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.apps,
                        color: Alla24Colors.button,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.filter_list,
                        color: Alla24Colors.button,
                      ),
                      onPressed: () {},
                    ),
                  ]),
                  Expanded(child: ProductsGrid(products))
                ]),
          )),
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
          icon: Icon(Icons.filter_list, color: Alla24Colors.white),
          onPressed: () {},
        )
      ],
    );
  }
}
