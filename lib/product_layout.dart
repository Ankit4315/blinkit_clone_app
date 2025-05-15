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
        "discountedPrice": 35,
      },
      {
        "name": "Onions",
        "image": "🧅",
        "price": 30,
        "weight": "1kg",
        "discountedPrice": null,
      },
      {
        "name": "Potatoes",
        "image": "🥔",
        "price": 50,
        "weight": "2kg",
        "discountedPrice": 45,
      },
      {
        "name": "Apples",
        "image": "🍎",
        "price": 120,
        "weight": "500g",
        "discountedPrice": null,
      },
      {
        "name": "Bananas",
        "image": "🍌",
        "price": 60,
        "weight": "1 dozen",
        "discountedPrice": 55,
      },
      {
        "name": "Milk",
        "image": "🥛",
        "price": 60,
        "weight": "1L",
        "discountedPrice": null,
      },
      {
        "name": "Bread",
        "image": "🍞",
        "price": 40,
        "weight": "400g",
        "discountedPrice": null,
      },
      {
        "name": "Eggs",
        "image": "🥚",
        "price": 80,
        "weight": "12 pcs",
        "discountedPrice": 70,
      },
    ];
  }
}

class ProductLayout extends StatelessWidget {
  final ScrollController controller;

  const ProductLayout({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: controller,
      padding: const EdgeInsets.only(bottom: 20),
      children: [
        _buildOfferBanners(),
        _buildFeaturedSection(),
        _buildPopularProductsSection(),
        _buildCategorySection("Grocery & Kitchen", ProductCategories.getGroceryCategories()),
        _buildCategorySection("Snacks & Drinks", ProductCategories.getSnacksAndDrinks()),
      ],
    );
  }

  Widget _buildOfferBanners() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 150,
          child: PageView.builder(
            itemCount: ProductCategories.getOfferBanners().length,
            itemBuilder: (context, index) {
              final banner = ProductCategories.getOfferBanners()[index];
              return Container(
                margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: banner["color"] as List<Color>,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        banner["title"],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        banner["subtitle"],
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "Shop Now",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              ProductCategories.getOfferBanners().length,
              (index) => Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index == 0 ? Colors.green : Colors.grey.shade300,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            "Featured this week",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: ProductCategories.getFeaturedItems().length,
            itemBuilder: (context, index) {
              final item = ProductCategories.getFeaturedItems()[index];
              return Container(
                width: 180,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: index % 4 == 0
                        ? [Colors.green.shade200, Colors.blue.shade200]
                        : index % 4 == 1
                            ? [Colors.brown.shade300, Colors.brown.shade800]
                            : index % 4 == 2
                                ? [Colors.purple.shade200, Colors.purple.shade300]
                                : [Colors.blue.shade200, Colors.blue.shade400],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "Featured",
                          style: TextStyle(
                            color: Colors.pink.shade400,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item["image"],
                            style: const TextStyle(fontSize: 32),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            item["title"],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPopularProductsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            "Popular Products",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: ProductCategories.getPopularProducts().length,
          itemBuilder: (context, index) {
            final product = ProductCategories.getPopularProducts()[index];
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image and discount badge
                  Stack(
                    children: [
                      Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                        ),
                        child: Center(
                          child: Text(
                            product["image"],
                            style: const TextStyle(fontSize: 50),
                          ),
                        ),
                      ),
                      if (product["discountedPrice"] != null)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              "${(100 - (product["discountedPrice"] / product["price"] * 100)).round()}% OFF",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  // Product details
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product["name"],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          product["weight"],
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            if (product["discountedPrice"] != null) ...[
                              Text(
                                "₹${product["discountedPrice"]}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "₹${product["price"]}",
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey.shade600,
                                  fontSize: 14,
                                ),
                              ),
                            ] else
                              Text(
                                "₹${product["price"]}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                            ),
                            child: const Text("ADD"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCategorySection(String title, List<Map<String, dynamic>> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 0.8,
            crossAxisSpacing: 8,
            mainAxisSpacing: 16,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: item["color"] ?? Colors.green.shade50,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      item["image"],
                      style: const TextStyle(fontSize: 28),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item["title"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
} 