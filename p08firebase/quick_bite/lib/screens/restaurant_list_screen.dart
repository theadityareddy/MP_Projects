import 'package:flutter/material.dart';
import 'package:quick_bite/models/restaurant.dart';
import 'package:quick_bite/screens/restaurant_detail_screen.dart';
import 'package:quick_bite/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RestaurantListScreen extends StatefulWidget {
  const RestaurantListScreen({super.key});

  @override
  State<RestaurantListScreen> createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  final List<String> categories = [
    'All',
    'North Indian',
    'South Indian',
    'Chinese',
    'Fast Food',
    'Desserts',
    'Beverages',
  ];

  String selectedCategory = 'All';

  final List<Restaurant> restaurants = [
    Restaurant(
      id: '1',
      name: 'Tandoori Nights',
      imageUrl: 'https://example.com/tandoori.jpg',
      rating: 4.5,
      deliveryTime: '30-40 min',
      cuisine: 'North Indian',
      isFavorite: false,
    ),
    Restaurant(
      id: '2',
      name: 'Dosa Plaza',
      imageUrl: 'https://example.com/dosa.jpg',
      rating: 4.2,
      deliveryTime: '25-35 min',
      cuisine: 'South Indian',
      isFavorite: false,
    ),
    Restaurant(
      id: '3',
      name: 'Wok & Roll',
      imageUrl: 'https://example.com/chinese.jpg',
      rating: 4.0,
      deliveryTime: '20-30 min',
      cuisine: 'Chinese',
      isFavorite: false,
    ),
    Restaurant(
      id: '4',
      name: 'Burger King',
      imageUrl: 'https://example.com/burger.jpg',
      rating: 4.3,
      deliveryTime: '15-25 min',
      cuisine: 'Fast Food',
      isFavorite: false,
    ),
    Restaurant(
      id: '5',
      name: 'Sweet Tooth',
      imageUrl: 'https://example.com/dessert.jpg',
      rating: 4.7,
      deliveryTime: '20-30 min',
      cuisine: 'Desserts',
      isFavorite: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Restaurants',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = category == selectedCategory;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    backgroundColor: AppTheme.surfaceColor,
                    selectedColor: AppTheme.primaryColor,
                    labelStyle: GoogleFonts.poppins(
                      color: isSelected ? AppTheme.onPrimaryColor : AppTheme.onSurfaceColor,
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = restaurants[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RestaurantDetailScreen(restaurant: restaurant),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: restaurant.imageUrl,
                              height: 200,
                              width: double.infinity,
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
                            Positioned(
                              top: 8,
                              right: 8,
                              child: IconButton(
                                icon: Icon(
                                  restaurant.isFavorite ? Icons.favorite : Icons.favorite_border,
                                  color: restaurant.isFavorite ? Colors.red : Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    restaurant.isFavorite = !restaurant.isFavorite;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                restaurant.name,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  RatingBar.builder(
                                    initialRating: restaurant.rating,
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
                                    '${restaurant.rating}',
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
                                    restaurant.deliveryTime,
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
                                    restaurant.cuisine,
                                    style: GoogleFonts.poppins(
                                      color: AppTheme.onSurfaceColor.withOpacity(0.7),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 