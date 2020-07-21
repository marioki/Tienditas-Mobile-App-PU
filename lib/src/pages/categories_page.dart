import 'package:app_tiendita/src/modelos/categoria_model.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/utils/crearCategoryList.dart';
import 'package:app_tiendita/src/widgets/category_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CategoryModel args = ModalRoute.of(context).settings.arguments;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * .25),
        child: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35),
            ),
          ),
          centerTitle: true,
          backgroundColor: azulTema,
          title: Text(
            'Categorías',
            style: appBarStyle,
          ),
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
                  itemCount: args.body.category.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    childAspectRatio: 3 / 3,
                  ),
                  itemBuilder: (context, index) {
                    final categories = getCategories();
                    return CategoryCard(
                      name: args.body.category[index].categoryName,
                      color: args.body.category[index].hexColor,
                      image: args.body.category[index].iconUrl,
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
