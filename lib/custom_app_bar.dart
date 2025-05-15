import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String currentAddress;
  final int selectedCategoryIndex;
  final Function(int) onCategoryTap;

  const CustomAppBar({
    super.key,
    required this.currentAddress,
    required this.selectedCategoryIndex,
    required this.onCategoryTap,
  });

  final List<Map<String, dynamic>> iconCategories = const [
    {"icon": Icons.shopping_bag, "label": "All"},
    {"icon": Icons.wb_sunny, "label": "Summer"},
    {"icon": Icons.headphones, "label": "Electronics"},
    {"icon": Icons.brush, "label": "Beauty"},
    {"icon": Icons.light, "label": "Decor"},
    {"icon": Icons.child_friendly, "label": "Kids"},
    {"icon": Icons.wallet_giftcard_rounded, "label": "Gifting"},
    {"icon": Icons.diamond_outlined, "label": "Premium"},
  ];

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 80,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.yellow, Colors.yellow.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Blinkit in", style: TextStyle(fontSize: 12, color: Colors.black)),
          Text("10 minutes", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
          Row(
            children: [
              Icon(Icons.location_on, size: 16, color: Colors.black),
              SizedBox(width: 4),
              Text("HOME - ", style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold)),
              Expanded(
                child: Text(
                  currentAddress,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.account_balance_wallet_outlined, color: Colors.black, size: 35),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.supervised_user_circle, color: Colors.black, size: 35),
          onPressed: () {},
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(110),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for products',
                  prefixIcon: Icon(Icons.search),
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            SizedBox(
              height: 60,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                itemCount: iconCategories.length,
                separatorBuilder: (_, __) => SizedBox(width: 30),
                itemBuilder: (context, index) {
                  final item = iconCategories[index];
                  final isSelected = index == selectedCategoryIndex;
                  return GestureDetector(
                    onTap: () => onCategoryTap(index),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(item["icon"], size: 20, color: Colors.black),
                        SizedBox(height: 2),
                        Text(
                          item["label"],
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
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(180); // Adjust as needed
}
