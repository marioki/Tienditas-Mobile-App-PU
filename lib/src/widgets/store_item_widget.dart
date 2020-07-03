import 'package:app_tiendita/src/tienditas_themes/my_themes.dart';
import 'package:app_tiendita/src/utils/constants.dart';
import 'package:flutter/material.dart';

class StoreItemCard extends StatelessWidget {
  final String name;
  final String deliveryNow;
  final double price;
  final String image;

  const StoreItemCard(
      {Key key,
      @required this.name,
      @required this.deliveryNow,
      @required this.price,
      @required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image(
            image: NetworkImage(
                'https://hips.hearstapps.com/hmg-prod.s3.amazonaws'
                '.com/images/wh-index-2000x1000-headphones-2-1590616427.jpg?crop=1'
                '.00xw:1.00xh;0,0&resize=1200:*'),
          ),
          Container(
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Sony Headphones',
                  style: storeItemTitleStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Entrega Inmediata'),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '\$50',
                  style: storeItemPriceStyle,
                ),
              ],
            ),
          ),
//          FlatButton(
//            onPressed: () {},
//            child: Text('Add to Cart'),
//          )
        ],
      ),
    );
  }
}

//import 'package:app_tiendita/src/utils/constants.dart';
//import 'package:flutter/material.dart';
//
//class StoreItemCard extends StatelessWidget {
//  final String name;
//  final String deliveryNow;
//  final double price;
//  final String image;
//
//  const StoreItemCard(
//      {Key key,
//        @required this.name,
//        @required this.deliveryNow,
//        @required this.price,
//        @required this.image})
//      : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    Size size = MediaQuery.of(context).size;
//
//    return Container(clipBehavior: Clip.antiAlias,
//
//      decoration: BoxDecoration(
//
//        color: Colors.grey.shade200,
//        borderRadius: BorderRadius.circular(30),
//        boxShadow: [
//          BoxShadow(
//            offset: Offset(0, 10),
//            blurRadius: 50,
//            color: kPrimaryColor.withOpacity(0.23),
//          ),
//        ],
//      ),
//      width: double.infinity,
//      child: Column(
//        children: <Widget>[
//          Expanded(
//            flex: 2,
//            child: Image(
//              fit: BoxFit.cover,
//              image: NetworkImage('https://i.pinimg.com/originals/21/eb/1f/21eb1f1de25367847e8b41a9149db65a.jpg'),
//            ),
//          ),
//          Expanded(
//            child: Column(
//
//              mainAxisAlignment: MainAxisAlignment.start,
//              crossAxisAlignment: CrossAxisAlignment.end,
//              mainAxisSize: MainAxisSize.min,
//              children: <Widget>[
//                Text('Headphones'),
//                Text('Headphones'),
//                Text('Headphones'),
//              ],
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//}
