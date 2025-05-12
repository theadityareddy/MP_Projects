import 'package:flutter/material.dart';
import 'product_detail.dart';

class Product {
  final String imageUrl;
  final String name;
  final int price;
  final String description;

  const Product({
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.description,
  });
}

class ProductsTab extends StatelessWidget {
  const ProductsTab({Key? key}) : super(key: key);

  final List<Product> products = const [
    Product(
      imageUrl: 'assets/img1.jpg',
      name: 'Maverick:Beard Balm',
      price: 2999,
      description: 'A gentleman leaves nothing to chance. Stack the deck in your favor with the warm scents of vanilla, Tobacco, and hints of cherry. This customer favorite is sure to give you the upper hand. Our Texas made Premium Beard balm helps to moisturize, condition, and soften your beard by protecting even the roughest skin while sealing in moisture and making that beard or mustache shine like a million bucks. Finally, you can kiss those stray hairs goodbye with Maverick Beard Balm by Daily Grind. If your main objective is beard growth then we suggest going with a beard growth kit. Simply add Maverick Beard Balm, Maverick Beard Oil and our Beard & Scruff Cream (Beard Moisturizer & Leave-in Conditioner) to the cart and you wll have all you need to promote massive beard growth.',
    ),
    Product(
      imageUrl: 'assets/img2.jpg',
      name: 'Beard Balm',
      price: 3499,
      description: 'Our Texas made Premium Beard balm helps to moisturize, condition, and soften your beard by protecting even the roughest skin while sealing in moisture and making that beard or mustache shine like a million bucks. Finally, you can kiss those stray hairs goodbye with The Duke Beard Balm by Daily Grind. If your main objective is beard growth then we suggest going with a beard growth kit. Simply add Maverick Beard Balm, Maverick Beard Oil and our Beard & Scruff Cream (Beard Moisturizer & Leave-in Conditioner) to the cart and you wll have all you need to promote massive beard growth.',
    ),
    Product(
      imageUrl: 'assets/img3.jpg',
      name: 'OutLaw: Beard Oil',
      price: 4999,
      description: '"Outlaw" is a subtle combo of Bourbon and Sandalwood. Made for the man who makes his own damn rules. Highlights: Musk, Bourbon, Woody',
    ),
    Product(
      imageUrl: 'assets/img4.jpg',
      name: 'The Rook: Beard Oil',
      price: 1999,
      description: 'Elevate your grooming experience with our "The Rook" beard oil, a blend that embodies the spirit of a refined gentleman. This oil is a tribute to enduring American charisma, featuring a sophisticated scent that intertwines boldness with polished finesse. Indulge in the opulent aroma of this exquisite blend, where the sharp, vivacious notes of white pepper meet the rich, enveloping warmth of dark amber, and the noble character of aged wood. Each element is meticulously selected to evoke a sense of storied American elegance - an adventure steeped in luxury and poise. The "American Classic" beard oil is not just about nourishment; its about making a statement. The invigorating spice of white pepper blends effortlessly with the sumptuous, deep scent of dark amber. The addition of oak brings a grounding, woody undertone, reminiscent of aged libraries and well-worn leather.',
    ),
    Product(
      imageUrl: 'assets/img5.jpg',
      name: 'Maverick:Beard Oil',
      price: 2999,
      description: 'A light, clean fragrance with hints of citrus, florals and woody undertones; harmonized by spice and musk. This scent is sure to turn some heads. If your main objective is beard growth then we suggest going with a beard growth kit. The Duke Beard Oil, Diesel Beard Beard Balm and our Beard & Scruff Cream (Beard Moisturizer & Leave-in Conditioner) to the cart and you wll have all you need to promote massive beard growth.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(product: products[index]);
      },
    );
  }
}

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isDescriptionVisible = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
      elevation: 6.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
            child: Image.asset(
              widget.product.imageUrl,
              height: 200, // Adjust the height as needed
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.name,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  '\₹${widget.product.price.toString()}',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.brown,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                if (_isDescriptionVisible)
                  Text(
                    widget.product.description,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[700],
                    ),
                  ),
                SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isDescriptionVisible = !_isDescriptionVisible;
                    });
                  },
                  child: Text(
                    _isDescriptionVisible ? 'Hide Details' : 'View Details',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
