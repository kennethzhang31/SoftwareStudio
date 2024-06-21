import 'package:flutter/material.dart';
import 'package:prototype_ss/model/product_model.dart';
import 'package:prototype_ss/widgets/buy_product_screen.dart';
import 'package:prototype_ss/widgets/product.dart';
class ProductCard extends StatefulWidget {
  final Product productData;

  const ProductCard({
    Key? key,
    required this.productData,
  }) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {

  void _showProductDetails(BuildContext context, Product productData) {
    showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return ProductContent(productData: productData);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Product productData = widget.productData;

    return InkWell(
      onTap: () {
        _showProductDetails(context, productData);
      },
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Stack(
          children: [
            ClipRRect(
              // borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                productData.imageUrl,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(10.0),
                color: Colors.black.withOpacity(0.5), // Optional: Add overlay for better text visibility
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    productData.name,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Make text color white for better contrast
                    ),
                  ),
                  Text(
                    '${productData.price} NTD',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white, // Make text color white for better contrast
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}