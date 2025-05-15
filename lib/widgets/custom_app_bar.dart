import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String currentAddress;
  final bool showAppBar;
  final AnimationController headerAnimationController;

  const CustomAppBar({
    Key? key,
    required this.currentAddress,
    required this.showAppBar,
    required this.headerAnimationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: headerAnimationController,
      axisAlignment: -1.0,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.yellow, Colors.yellow.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: AppBar(
          elevation: 0,
          toolbarHeight: 80,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
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
        ),
      ),
    );
  }
} 