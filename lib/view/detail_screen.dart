import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tempod/provider/product_provider.dart';

class DetailScreen extends ConsumerWidget {
  final int id;
  const DetailScreen({super.key, required  this.id});

  @override
  Widget build(BuildContext context,ref) {
    final state = ref.watch(productByIdProvider(id));
    return state.when(
        data: (data){
          return Column(
            children: [
              SizedBox(height: 100, child: Image.network(data.images[0])),
              Text(data.title, maxLines: 1),
              Text(data.price.toString()),
            ],
          );
        },
        error: (err, st) {
          return Center(child: Text('$err'));
        },
        loading: () => Center(child: CircularProgressIndicator()));
  }
}
