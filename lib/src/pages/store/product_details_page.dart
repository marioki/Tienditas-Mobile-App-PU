import 'package:app_tiendita/src/widgets/product_item_card.dart';
import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductItemCard args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Image(
                image: NetworkImage(args.imageUrl),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(args.itemName),
                      Text(args.finalPrice),
                    ],
                  ),
                  Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit'
                      ', sed do eiusmod tempor incididunt ut labore et dolo'
                      're magna aliqua. Ut enim ad minim veniam, quis nostr'
                      'ud exercitation ullamco laboris nisi ut aliquip ex '
                      'ea commodo consequat. Duis aute irure dolor in repre'
                      'henderit in voluptate velit esse cillum dolore eu f'
                      'ugiat nulla pariatur. Excepteur sint occaecat cupida'
                      'tat non proident, sunt in culpa qui officia deserunt'
                      ' mollit anim id est laborum'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
