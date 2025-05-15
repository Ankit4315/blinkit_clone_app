import 'package:flutter/material.dart';

class ProductCategories {
  static List<Map<String, dynamic>> getFeaturedItems() {
    return [
      {
        "title": "Mangoes & Melons",
        "image": "🍈🥭🍉",
        "isFeatured": true,
      },
      {
        "title": "Baking Corner",
        "image": "🧁🍪",
        "isFeatured": true,
      },
      {
        "title": "Chocolate Gift Packs",
        "image": "🍫🎁",
        "isFeatured": true,
      },
      {
        "title": "Ready to Eat",
        "image": "🍲🥡",
        "isFeatured": true,
      },
    ];
  }

  static List<Map<String, dynamic>> getOfferBanners() {
    return [
      {
        "title": "50% OFF on First Order",
        "subtitle": "Use code: FIRST50",
        "color": [Colors.purple.shade300, Colors.purple.shade700],
      },
      {
        "title": "Buy 1 Get 1 Free",
        "subtitle": "On all dairy products",
        "color": [Colors.blue.shade300, Colors.blue.shade700],
      },
      {
        "title": "Free Delivery",
        "subtitle": "On orders above ₹499",
        "color": [Colors.orange.shade300, Colors.orange.shade700],
      },
    ];
  }

  static List<Map<String, dynamic>> getGroceryCategories() {
    return [
      {
        "title": "Vegetables & Fruits",
        "image": "🥑🍎🍉🥭",
        "color": Colors.green.shade50,
      },
      {
        "title": "Atta, Rice & Dal",
        "image": "🌾🍚",
        "color": Colors.amber.shade50,
      },
      {
        "title": "Oil, Ghee & Masala",
        "image": "🧴🧂",
        "color": Colors.orange.shade50,
      },
      {
        "title": "Dairy, Bread & Eggs",
        "image": "🥛🍞🥚",
        "color": Colors.blue.shade50,
      },
      {
        "title": "Bakery & Biscuits",
        "image": "🍪🥐",
        "color": Colors.brown.shade50,
      },
      {
        "title": "Dry Fruits & Cereals",
        "image": "🥜🥣",
        "color": Colors.yellow.shade50,
      },
      {
        "title": "Chicken, Meat & Fish",
        "image": "🍗🥩🐟",
        "color": Colors.red.shade50,
      },
      {
        "title": "Kitchenware & Appliances",
        "image": "🍳🔪",
        "color": Colors.grey.shade50,
      },
    ];
  }

  static List<Map<String, dynamic>> getSnacksAndDrinks() {
    return [
      {
        "title": "Chips & Namkeen",
        "image": "🍟🥨",
        "color": Colors.amber.shade50,
      },
      {
        "title": "Sweets & Chocolates",
        "image": "🍬🍫",
        "color": Colors.purple.shade50,
      },
      {
        "title": "Drinks & Juices",
        "image": "🥤🧃",
        "color": Colors.blue.shade50,
      },
      {
        "title": "Tea, Coffee & Milk Drinks",
        "image": "☕🥛",
        "color": Colors.brown.shade50,
      },
    ];
  }

  static List<Map<String, dynamic>> getPopularProducts() {
    return [
      {
        "name": "Fresh Tomatoes",
        "image": "🍅",
        "price": 40,
        "weight": "500g",
        "category": "Vegetables",
        "discountedPrice": 35,
      },
      {
        "name": "Onions",
        "image": "🧅",
        "price": 30,
        "weight": "1kg",
        "category": "Vegetables",
        "discountedPrice": null,
      },
      {
        "name": "Potatoes",
        "image": "🥔",
        "price": 50,
        "weight": "2kg",
        "category": "Vegetables",
        "discountedPrice": 45,
      },
      {
        "name": "Apples",
        "image": "🍎",
        "price": 120,
        "weight": "500g",
        "category": "Fruits",
        "discountedPrice": null,
      },
      {
        "name": "Bananas",
        "image": "🍌",
        "price": 60,
        "weight": "1 dozen",
        "category": "Fruits",
        "discountedPrice": 55,
      },
      {
        "name": "Milk",
        "image": "🥛",
        "price": 60,
        "weight": "1L",
        "category": "Dairy",
        "discountedPrice": null,
      },
      {
        "name": "Bread",
        "image": "🍞",
        "price": 40,
        "weight": "400g",
        "category": "Bakery",
        "discountedPrice": null,
      },
      {
        "name": "Eggs",
        "image": "🥚",
        "price": 80,
        "weight": "12 pcs",
        "category": "Dairy",
        "discountedPrice": 70,
      },
    ];
  }

  static List<Map<String, dynamic>> searchProducts(String query) {
    if (query.isEmpty) {
      return [];
    }
    
    final normalizedQuery = query.toLowerCase().trim();
    
    // For single character searches, only match at the beginning of words
    final bool isShortQuery = normalizedQuery.length <= 2;
    
    final allProducts = [
      ...getPopularProducts(),
      ...getGroceryCategories().map((item) => {
        "name": item["title"],
        "image": item["image"],
        "price": 99,
        "weight": "1 unit",
        "category": "Grocery",
        "discountedPrice": null,
      }),
      ...getSnacksAndDrinks().map((item) => {
        "name": item["title"],
        "image": item["image"],
        "price": 99,
        "weight": "1 unit",
        "category": "Snacks",
        "discountedPrice": null,
      }),
    ];
    
    return allProducts.where((product) {
      final name = product["name"].toString().toLowerCase();
      final category = product["category"]?.toString().toLowerCase() ?? "";
      
      if (isShortQuery) {
        // For short queries, check if any word in the name starts with the query
        final words = name.split(' ');
        final categoryWords = category.split(' ');
        
        return words.any((word) => word.startsWith(normalizedQuery)) ||
               categoryWords.any((word) => word.startsWith(normalizedQuery));
      } else {
        // For longer queries, check if name or category contains the query
        return name.contains(normalizedQuery) || 
               category.contains(normalizedQuery);
      }
    }).toList();
  }
} 