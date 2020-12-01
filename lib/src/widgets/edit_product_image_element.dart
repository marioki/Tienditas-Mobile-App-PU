import 'package:flutter/material.dart';

class ProductImgEdt extends StatefulWidget {
  final productImage;

  final index;
  final Function onDelete;

  const ProductImgEdt(
      {Key key,
      @required this.productImage,
      @required this.index,
      @required this.onDelete})
      : super(key: key);

  @override
  _ProductImgEdtState createState() => _ProductImgEdtState();
}

class _ProductImgEdtState extends State<ProductImgEdt> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image(
            image: widget.productImage,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          IconButton(
              icon: Icon(Icons.delete_forever_sharp),
              onPressed:widget.onDelete)
        ],
      ),
    );
  }
}
