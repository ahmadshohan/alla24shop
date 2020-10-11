import 'package:alla24/colors.dart';
import 'package:alla24/shared/widgets/closable.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class AppSearchBar {
  static buildFullAppBar(BuildContext context) {
    return AppBar(
        backgroundColor: Alla24Colors.button,
        leading: IconButton(
          icon: Icon(
            EvaIcons.menu,
            color: Alla24Colors.white,
          ),
          onPressed: () {},
        ),
        title: Padding(
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
                        style: TextStyle(fontSize: 15.0, color: Colors.black),
                        // controller: _searchController,
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
            ])),
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
}
