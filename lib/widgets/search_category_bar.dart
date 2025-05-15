import 'package:flutter/material.dart';
import 'dart:async';

class SearchCategoryBar extends StatefulWidget {
  final int selectedCategoryIndex;
  final Function(int) onCategoryTap;
  final Function(String) onSearch;
  final TextEditingController searchController;
  final FocusNode searchFocusNode;

  const SearchCategoryBar({
    Key? key,
    required this.selectedCategoryIndex,
    required this.onCategoryTap,
    required this.onSearch,
    required this.searchController,
    required this.searchFocusNode,
  }) : super(key: key);

  @override
  State<SearchCategoryBar> createState() => _SearchCategoryBarState();
}

class _SearchCategoryBarState extends State<SearchCategoryBar> {
  Timer? _debounceTimer;

  // Debounce function to avoid too frequent search calls
  void _onSearchChanged(String value) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    
    // Very short debounce for a more responsive experience
    final debounceTime = value.length <= 1 ? 
                          const Duration(milliseconds: 100) : 
                          const Duration(milliseconds: 200);
    
    _debounceTimer = Timer(debounceTime, () {
      // Even for empty value, we call onSearch to clear results
      widget.onSearch(value.trim());
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.yellow.shade50,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: TextField(
              controller: widget.searchController,
              focusNode: widget.searchFocusNode,
              decoration: InputDecoration(
                hintText: 'Search for products',
                prefixIcon: Icon(Icons.search),
                suffixIcon: widget.searchController.text.isNotEmpty 
                  ? IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        widget.searchController.clear();
                        // Hide keyboard and clear focus
                        widget.searchFocusNode.unfocus();
                        // Trigger empty search to clear results
                        widget.onSearch('');
                      },
                    )
                  : null,
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.white,
                filled: true,
              ),
              onChanged: _onSearchChanged,
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  widget.onSearch(value.trim());
                }
              },
              textInputAction: TextInputAction.search,
            ),
          ),
          SizedBox(
            height: 60,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemCount: 8,
              separatorBuilder: (_, __) => SizedBox(width: 30),
              itemBuilder: (context, index) {
                final iconCategories = [
                  {"icon": Icons.shopping_bag, "label": "All"},
                  {"icon": Icons.wb_sunny, "label": "Summer"},
                  {"icon": Icons.headphones, "label": "Electronics"},
                  {"icon": Icons.brush, "label": "Beauty"},
                  {"icon": Icons.light, "label": "Decor"},
                  {"icon": Icons.child_friendly, "label": "Kids"},
                  {"icon": Icons.wallet_giftcard_rounded, "label": "Gifting"},
                  {"icon": Icons.diamond_outlined, "label": "Premium"},
                ];
                final item = iconCategories[index];
                final isSelected = index == widget.selectedCategoryIndex;
                return GestureDetector(
                  onTap: () => widget.onCategoryTap(index),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(item["icon"] as IconData, size: 20, color: Colors.black),
                      SizedBox(height: 2),
                      Text(
                        item["label"] as String,
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 10),
                      ),
                      SizedBox(height: 2),
                      Container(
                        height: 4,
                        width: 30,
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.black : Colors.transparent,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
                        ),
                      ),
                    ],
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