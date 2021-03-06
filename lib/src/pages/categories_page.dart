import 'package:app_tiendita/src/modelos/categoria_model.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/widgets/category_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CategoryResponseModel args = ModalRoute.of(context).settings.arguments;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        toolbarHeight: 100,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35))),
        centerTitle: true,
        backgroundColor: azulTema,
        title: Column(
          children: [
            Text(
              'Categorías',
              style: appBarStyle,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: GridView.builder(
                  itemCount: args.body.categoryList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    childAspectRatio: 3 / 3,
                  ),
                  itemBuilder: (context, index) {
                    return CategoryCard(
                      name: args.body.categoryList[index].categoryName,
                      color: args.body.categoryList[index].hexColor,
                      image: args.body.categoryList[index].iconUrl,
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
