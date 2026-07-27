import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tempod/provider/screen_provider.dart';
import 'package:tempod/view/cart_screen.dart';
import 'package:tempod/view/home_screen.dart';
import 'package:tempod/view/profile_screen.dart';
import 'package:tempod/view/search_screen.dart';

class MyBottomNavbar extends ConsumerWidget {
  const MyBottomNavbar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final num = ref.watch(screenNumProvider);
    final screens = [
      HomeScreen(),
      SearchScreen(),
      CartScreen(),
      ProfileScreen(),
    ];
    return Scaffold(
      body: screens[num],
      bottomNavigationBar: BottomNavigationBar(
       onTap: (index){
         ref.read(screenNumProvider.notifier).state=index;
       },
        type: BottomNavigationBarType.fixed,
        currentIndex: num,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
