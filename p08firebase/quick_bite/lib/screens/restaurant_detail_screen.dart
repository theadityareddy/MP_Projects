import 'package:flutter/material.dart';
import 'package:quick_bite/models/restaurant.dart';
import 'package:quick_bite/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:quick_bite/providers/cart_provider.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantDetailScreen({super.key, required this.restaurant});

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  final List<Map<String, dynamic>> menuItems = [
    {
      'id': '1',
      'name': 'Butter Chicken',
      'description': 'Tender chicken pieces in a rich, creamy tomato sauce',
      'price': 299,
      'imageUrl': 'https://example.com/butter-chicken.jpg',
      'category': 'Main Course',
    },
    {
      'id': '2',
      'name': 'Paneer Tikka',
      'description': 'Grilled cottage cheese marinated in spices',
      'price': 249,
      'imageUrl': 'https://example.com/paneer-tikka.jpg',
      'category': 'Starters',
    },
    {
      'id': '3',
      'name': 'Dal Makhani',
      'description': 'Creamy black lentils cooked with butter and cream',
      'price': 199,
      'imageUrl': 'https://example.com/dal-makhani.jpg',
      'category': 'Main Course',
    },
    {
      'id': '4',
      'name': 'Gulab Jamun',
      'description': 'Sweet milk dumplings in sugar syrup',
      'price': 99,
      'imageUrl': 'https://example.com/gulab-jamun.jpg',
      'category': 'Desserts',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: widget.restaurant.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: AppTheme.surfaceColor,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: AppTheme.surfaceColor,
                  child: const Icon(Icons.error),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.restaurant.name,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      RatingBar.builder(
                        initialRating: widget.restaurant.rating,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 20,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {},
                        ignoreGestures: true,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${widget.restaurant.rating}',
                        style: GoogleFonts.poppins(
                          color: AppTheme.onSurfaceColor.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.timer,
                        size: 16,
                        color: AppTheme.onSurfaceColor.withOpacity(0.7),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.restaurant.deliveryTime,
                        style: GoogleFonts.poppins(
                          color: AppTheme.onSurfaceColor.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.restaurant,
                        size: 16,
                        color: AppTheme.onSurfaceColor.withOpacity(0.7),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.restaurant.cuisine,
                        style: GoogleFonts.poppins(
                          color: AppTheme.onSurfaceColor.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Menu',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = menuItems[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name'],
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item['description'],
                                style: GoogleFonts.poppins(
                                  color: AppTheme.onSurfaceColor.withOpacity(0.7),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '₹${item['price']}',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_shopping_cart),
                          onPressed: () {
                            final cartProvider = Provider.of<CartProvider>(context, listen: false);
                            cartProvider.addToCart(item);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${item['name']} added to cart'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: menuItems.length,
            ),
          ),
        ],
      ),
    );
  }
} 