import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/search_category_bar.dart';
import '../widgets/product_layout.dart';
import '../models/product_categories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  String _currentAddress = "Fetching location...";
  int _selectedCategoryIndex = 0;
  int _selectedTabIndex = 0;
  late ScrollController _scrollController;
  late AnimationController _headerAnimationController;
  late AnimationController _bottomNavAnimationController;
  
  // Search-related state
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  String _searchQuery = '';
  List<Map<String, dynamic>> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    
    // Initialize scroll controller
    _scrollController = ScrollController();
    _scrollController.addListener(_handleScroll);
    
    // Initialize animation controllers
    _headerAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      value: 1.0, // Start fully visible
    );
    
    _bottomNavAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      value: 1.0, // Start fully visible
    );
  }

  void _handleScroll() {
    // For scrolling down
    if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      _headerAnimationController.fling(velocity: -2.0);
      _bottomNavAnimationController.fling(velocity: -2.0);
    } 
    // For scrolling up
    else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
      _headerAnimationController.fling(velocity: 2.0);
      _bottomNavAnimationController.fling(velocity: 2.0);
    }
    
    // Always show both when at the top
    if (_scrollController.position.pixels <= 0) {
      _headerAnimationController.animateTo(1.0);
      _bottomNavAnimationController.animateTo(1.0);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _headerAnimationController.dispose();
    _bottomNavAnimationController.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    var status = await Permission.location.request();

    if (status.isDenied || status.isPermanentlyDenied) return;
    if (!await Geolocator.isLocationServiceEnabled()) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) return;
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;
      setState(() {
        _currentAddress = "${place.subLocality ?? ''}, ${place.locality ?? ''}";
      });
    } else {
      setState(() {
        _currentAddress = "Address not found";
      });
    }
  }

  void _handleSearch(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _searchResults = [];
      } else {
        _searchResults = ProductCategories.searchProducts(query);
      }
    });
  }

  void _clearSearch() {
    setState(() {
      _searchQuery = '';
      _searchResults = [];
      _searchController.clear();
      _searchFocusNode.unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _selectedTabIndex == 0
          ? Column(
              children: [
                CustomAppBar(
                  currentAddress: _currentAddress,
                  showAppBar: true,
                  headerAnimationController: _headerAnimationController,
                ),
                SearchCategoryBar(
                  selectedCategoryIndex: _selectedCategoryIndex,
                  onCategoryTap: (index) {
                    setState(() {
                      _selectedCategoryIndex = index;
                      _searchResults = []; // Clear search when changing category
                    });
                  },
                  onSearch: _handleSearch,
                  searchController: _searchController,
                  searchFocusNode: _searchFocusNode,
                ),
                Expanded(
                  child: _searchQuery.isNotEmpty 
                    ? _buildSearchResults()
                    : ProductLayout(
                        controller: _scrollController,
                      ),
                ),
              ],
            )
          : _buildOtherTabContent(),
      ),
      bottomNavigationBar: SizeTransition(
        sizeFactor: _bottomNavAnimationController,
        axisAlignment: 1.0,
        child: BottomNavigationBar(
          currentIndex: _selectedTabIndex,
          onTap: (index) {
            setState(() {
              _selectedTabIndex = index;
              if (_searchQuery.isNotEmpty) {
                _clearSearch(); // Clear search when changing tabs
              }
            });
          },
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.refresh), label: 'Order Again'),
            BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.print), label: 'Profile'),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off, size: 80, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'No results found for "$_searchQuery"',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Try a different search term',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Results for "${_searchQuery}"',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: _clearSearch,
                child: const Text('Clear'),
              ),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: _searchResults.length,
            itemBuilder: (context, index) {
              final product = _searchResults[index];
              
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
                          height: 110,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                          ),
                          child: Center(
                            child: Text(
                              product["image"] as String,
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
                          Positioned(
                            bottom: 8,
                            left: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                product["category"] as String,
                                style: TextStyle(
                                  color: Colors.grey.shade700,
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
                            product["name"] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            product["weight"] as String,
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
        ),
      ],
    );
  }

  Widget _buildOtherTabContent() {
    switch (_selectedTabIndex) {
      case 1:
        return const Center(child: Text("Order Again", style: TextStyle(fontSize: 18)));
      case 2:
        return const Center(child: Text("Categories", style: TextStyle(fontSize: 18)));
      case 3:
        return const Center(child: Text("Print Store", style: TextStyle(fontSize: 18)));
      default:
        return const Center(child: Text("Unexpected tab", style: TextStyle(fontSize: 18)));
    }
  }
} 