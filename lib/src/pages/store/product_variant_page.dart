import 'package:app_tiendita/src/modelos/product_model.dart';
import 'package:flutter/material.dart';
import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';


class ProductVariant extends StatefulWidget {
  ProductVariant({this.variants, this.saveButtonIsVisible});
  final List<Variant> variants;
  bool saveButtonIsVisible;
  @override
  _ProductVariantState createState() => _ProductVariantState();
}

class _ProductVariantState extends State<ProductVariant> {
  final _formKey = GlobalKey<FormState>();
  String popUpVariantName;
  String popUpVariantQuantity;
  String popUpVariantPrice;
  List<Variant> variants = [];

  void reloadVariantsListView(String name, String quantity, String price) {
    setState(() {
      widget.saveButtonIsVisible = true;
      Variant variant = new Variant();
      variant.name = name;
      variant.quantity = quantity;
      variant.price = price;
      variants.add(
        variant
      );
    });
  }
  
  @override
  Widget build(BuildContext context) {
    if (widget.variants != null ) {
      variants = widget.variants;
      for (var item in variants) {
        print(item.name);
        
      }
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35)),
        ),
        centerTitle: true,
        toolbarHeight: 100,
        backgroundColor: azulTema,
        title: Text(
          'Variantes',
          style: appBarStyle,
        ),
        actions: <Widget>[
          IconButton(
            iconSize: 38.0,
            icon: Icon(Icons.add_circle),
            padding: EdgeInsets.only(right: 16.0),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return StatefulBuilder(builder: (context, setState) {
                    return AlertDialog(
                      elevation: 10,
                      title: Text(
                        "Añade una variante",
                        style: TextStyle(
                            color: Color(0xFF191660),
                            fontSize: 25,
                            fontWeight: FontWeight.normal,
                            fontFamily: "Nunito"),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Nombre",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                fontFamily: "Nunito"),
                          ),
                          TextFormField(
                            onChanged: (String value) {
                              popUpVariantName = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Ingresar nombre';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                hintText: 'azul talla m'),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Cantidad disponible",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                fontFamily: "Nunito"),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            onChanged: (String value) {
                              popUpVariantQuantity = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Ingresar cantidad';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                hintText: '4'),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Precio",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                fontFamily: "Nunito"),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            onChanged: (String value) {
                              popUpVariantPrice = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Ingresar precio';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                hintText: '1.00'),
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('Agregar'),
                          color: Color(0xFF191660),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          onPressed: () async {
                            reloadVariantsListView(
                              popUpVariantName,
                              popUpVariantQuantity,
                              popUpVariantPrice
                            );
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  });
                },
              );
            },
          )
        ],
      ),
      body: Container(
        height: double.infinity,
        child: SingleChildScrollView(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 500,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  shrinkWrap: true,
                  itemCount: variants.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.only(top: 5),
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        color: Colors.white,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    "${variants[index].name}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: "Nunito"),
                                  ),
                                  Spacer(),
                                  IconButton(
                                    icon: Icon(Icons.delete_outline),
                                    iconSize: 22,
                                    onPressed: () {
                                      setState(() {
                                        variants.removeAt(index);
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "disponible ${variants[index].quantity}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: "Nunito"),
                                  ),
                                  Spacer(),
                                  Text(
                                    "\$ ${variants[index].price}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: "Nunito"),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 8),
              Visibility(
                visible: widget.saveButtonIsVisible,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.pop(context, variants);
                  },
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  textColor: Colors.white,
                  child: Text(
                    "Guardar",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        fontFamily: "Nunito"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
  );}
}