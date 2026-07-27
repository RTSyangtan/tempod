import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempod/view/add_product_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hello User'),backgroundColor: Colors.deepPurple,),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
                Get.to(()=>AddProductScreen());
            }, child: Text('Add a Product'))
          ],
        ),
      ),
    );;
  }
}
