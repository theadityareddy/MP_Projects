import 'package:flutter/material.dart';
import 'package:quick_bite/models/restaurant.dart';
import 'package:quick_bite/screens/restaurant_detail_screen.dart';
import 'package:quick_bite/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final List<Restaurant> favoriteRestaurants = [
    Restaurant(
      id: '1',
      name: 'Tandoori Nights',
      imageUrl: 'https://example.com/tandoori.jpg',
      rating: 4.5,
      deliveryTime: '30-40 min',
      cuisine: 'North Indian',
      isFavorite: true,
    ),
    Restaurant(
      id: '2',
      name: 'Dosa Plaza',
      imageUrl: 'https://example.com/dosa.jpg',
      rating: 4.2,
      deliveryTime: '25-35 min',
      cuisine: 'South Indian',
      isFavorite: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorites',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: favoriteRestaurants.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 64,
                    color: AppTheme.onSurfaceColor.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No favorite restaurants yet',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: AppTheme.onSurfaceColor.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: favoriteRestaurants.length,
              itemBuilder: (context, index) {
                final restaurant = favoriteRestaurants[index];
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
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  setState(() {
                                    favoriteRestaurants.removeAt(index);
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
    );
  }
} 