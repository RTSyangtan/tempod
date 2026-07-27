import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tempod/provider/product_provider.dart';

class PaginationProduct extends ConsumerWidget {
  const PaginationProduct({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final state = ref.watch(paginationProvider);
    final ScrollController scrollController = ScrollController();
    
    scrollController.addListener((){
      if(scrollController.position.pixels ==
      scrollController.position.maxScrollExtent){
       ref.read(paginationProvider.notifier).loadMore();
      }
    });
    
    return Scaffold(
      appBar: AppBar(title: Text("Pagi"),),
      body: state.when(
        data: (data) {
          return GridView.builder(
            controller: scrollController,
            padding: EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 160,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final product = data[index];
              return Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 100, child: Image.network(product.images[0])),
                  Text(product.title, maxLines: 1),
                  Text(product.price.toString()),
                ],
              );
            },
          );
        },
        error: (err, st) {
          return Center(child: Text('$err'));
        },
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
