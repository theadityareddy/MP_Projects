import 'package:flutter/material.dart';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String imagePath;
  final double rating;
  final String deliveryTime;
  final String deliveryFee;
  final List<FoodItem> menu;
  final bool isFavorite;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.rating,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.menu,
    this.isFavorite = false,
  });
}

class FoodItem {
  final String id;
  final String name;
  final String description;
  final String imagePath;
  final double price;
  final List<String> categories;
  final bool isFavorite;

  FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.categories,
    this.isFavorite = false,
  });
}

class RestaurantProvider with ChangeNotifier {
  List<Restaurant> _restaurants = [
    Restaurant(
      id: '1',
      name: 'Burger King',
      description: 'Home of the Whopper',
      imagePath: 'assets/images/restaurants/burger_king.jpg',
      rating: 4.5,
      deliveryTime: '20-30 min',
      deliveryFee: '\$2.99',
      menu: [
        FoodItem(
          id: '1',
          name: 'Whopper',
          description: 'Flame-grilled beef patty with fresh toppings',
          imagePath: 'assets/images/menu/whopper.jpg',
          price: 5.99,
          categories: ['Burgers', 'Fast Food'],
        ),
        FoodItem(
          id: '2',
          name: 'Chicken Fries',
          description: 'Crispy chicken strips in fry shape',
          imagePath: 'assets/images/menu/chicken_fries.jpg',
          price: 3.99,
          categories: ['Chicken', 'Fast Food'],
        ),
      ],
    ),
    Restaurant(
      id: '2',
      name: 'Pizza Hut',
      description: 'World\'s Favorite Pizza',
      imagePath: 'assets/images/restaurants/pizza_hut.jpg',
      rating: 4.3,
      deliveryTime: '25-35 min',
      deliveryFee: '\$1.99',
      menu: [
        FoodItem(
          id: '3',
          name: 'Pepperoni Pizza',
          description: 'Classic pepperoni pizza with extra cheese',
          imagePath: 'assets/images/menu/pepperoni_pizza.jpg',
          price: 12.99,
          categories: ['Pizza', 'Italian'],
        ),
        FoodItem(
          id: '4',
          name: 'Garlic Bread',
          description: 'Freshly baked bread with garlic butter',
          imagePath: 'assets/images/menu/garlic_bread.jpg',
          price: 4.99,
          categories: ['Appetizers', 'Italian'],
        ),
      ],
    ),
    Restaurant(
      id: '3',
      name: 'Sushi Master',
      description: 'Authentic Japanese Cuisine',
      imagePath: 'assets/images/restaurants/sushi_master.jpg',
      rating: 4.8,
      deliveryTime: '30-40 min',
      deliveryFee: '\$3.99',
      menu: [
        FoodItem(
          id: '5',
          name: 'California Roll',
          description: 'Crab, avocado, and cucumber roll',
          imagePath: 'assets/images/menu/california_roll.jpg',
          price: 8.99,
          categories: ['Sushi', 'Japanese'],
        ),
        FoodItem(
          id: '6',
          name: 'Miso Soup',
          description: 'Traditional Japanese soup with tofu',
          imagePath: 'assets/images/menu/miso_soup.jpg',
          price: 3.99,
          categories: ['Soup', 'Japanese'],
        ),
      ],
    ),
  ];

  List<Restaurant> get restaurants => _restaurants;

  List<Restaurant> get favoriteRestaurants =>
      _restaurants.where((restaurant) => restaurant.isFavorite).toList();

  void toggleFavorite(String restaurantId) {
    final index = _restaurants.indexWhere((r) => r.id == restaurantId);
    if (index != -1) {
      _restaurants[index] = Restaurant(
        id: _restaurants[index].id,
        name: _restaurants[index].name,
        description: _restaurants[index].description,
        imagePath: _restaurants[index].imagePath,
        rating: _restaurants[index].rating,
        deliveryTime: _restaurants[index].deliveryTime,
        deliveryFee: _restaurants[index].deliveryFee,
        menu: _restaurants[index].menu,
        isFavorite: !_restaurants[index].isFavorite,
      );
      notifyListeners();
    }
  }

  List<FoodItem> getAllFoodItems() {
    return _restaurants.expand((restaurant) => restaurant.menu).toList();
  }

  List<FoodItem> getFavoriteFoodItems() {
    return getAllFoodItems().where((item) => item.isFavorite).toList();
  }

  void toggleFoodItemFavorite(String foodItemId) {
    for (var restaurant in _restaurants) {
      final index = restaurant.menu.indexWhere((item) => item.id == foodItemId);
      if (index != -1) {
        final updatedMenu = List<FoodItem>.from(restaurant.menu);
        updatedMenu[index] = FoodItem(
          id: updatedMenu[index].id,
          name: updatedMenu[index].name,
          description: updatedMenu[index].description,
          imagePath: updatedMenu[index].imagePath,
          price: updatedMenu[index].price,
          categories: updatedMenu[index].categories,
          isFavorite: !updatedMenu[index].isFavorite,
        );
        _restaurants[_restaurants.indexOf(restaurant)] = Restaurant(
          id: restaurant.id,
          name: restaurant.name,
          description: restaurant.description,
          imagePath: restaurant.imagePath,
          rating: restaurant.rating,
          deliveryTime: restaurant.deliveryTime,
          deliveryFee: restaurant.deliveryFee,
          menu: updatedMenu,
          isFavorite: restaurant.isFavorite,
        );
        notifyListeners();
        break;
      }
    }
  }
} 