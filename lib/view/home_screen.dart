import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:tempod/provider/product_provider.dart';
import 'package:tempod/view/detail_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(productProvider);
    return state.when(
      data: (data) {
        return GridView.builder(
          padding: EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 160,
          ),
          itemCount: data.length,
          itemBuilder: (context, index) {
            final product = data[index];
            return InkWell(
              onTap: (){
                Get.to(()=>DetailScreen(id: product.id));
              },
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 100, child: Image.network(product.images[0])),
                  Text(product.title, maxLines: 1),
                  Text(product.price.toString()),
                ],
              ),
            );
          },
        );
      },
      error: (err, st) {
        return Center(child: Text('$err'));
      },
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}
