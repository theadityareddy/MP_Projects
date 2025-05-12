import 'package:flutter/foundation.dart';
import 'package:quick_bite/models/restaurant.dart';

class RestaurantProvider with ChangeNotifier {
  final List<Restaurant> _restaurants = [
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

  List<Restaurant> get restaurants => _restaurants;
  List<Restaurant> get favoriteRestaurants => _restaurants.where((r) => r.isFavorite).toList();

  void toggleFavorite(String restaurantId) {
    final index = _restaurants.indexWhere((r) => r.id == restaurantId);
    if (index != -1) {
      _restaurants[index].isFavorite = !_restaurants[index].isFavorite;
      notifyListeners();
    }
  }

  List<Restaurant> getRestaurantsByCategory(String category) {
    if (category == 'All') {
      return _restaurants;
    }
    return _restaurants.where((r) => r.cuisine == category).toList();
  }

  Restaurant? getRestaurantById(String id) {
    try {
      return _restaurants.firstWhere((r) => r.id == id);
    } catch (e) {
      return null;
    }
  }
} 