import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tempod/model/create_product_model.dart';
import 'package:tempod/provider/created_product_provider.dart';

class AddProductScreen extends ConsumerStatefulWidget {
  const AddProductScreen({super.key});

  @override
  ConsumerState<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends ConsumerState<AddProductScreen> {
  final imgPicker = ImagePicker();
  XFile? selectedImage;

  Future<void> pickImage() async {
    final image = await imgPicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = image;
      });
    }
  }

  final titleCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final newProductProvider = ref.watch(createdProductProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Create Product')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 10,
          children: [
            TextFormField(
              controller: titleCtrl,
              decoration: InputDecoration(
                hintText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            TextFormField(
              controller: priceCtrl,
              decoration: InputDecoration(
                hintText: 'Price',
                border: OutlineInputBorder(),
              ),
            ),
            TextFormField(
              controller: descriptionCtrl,
              decoration: InputDecoration(
                hintText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            InkWell(
              onTap: () {
                pickImage();
              },
              child: Container(
                color: Colors.black26,
                height: 100,
                width: double.infinity,
                child: selectedImage == null
                    ? Center(child: Text('ChooseFile'))
                    : Image.file(File(selectedImage!.path), fit: BoxFit.cover),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final product = CreateProductModel(
                  title: titleCtrl.text,
                  price: int.tryParse(priceCtrl.text) ?? 0,
                  description: descriptionCtrl.text,
                  categoryId: 1,
                  // images: [selectedImage!.path]
                  images: ['https://placehold.co/600x400'],
                );

                await ref
                    .read(createdProductProvider.notifier)
                    .addCreatedProduct(product);

                final state = ref.read(createdProductProvider);
                if (!state.hasError) {
                  Get.snackbar(
                    'Success',
                    'Product Created Successfully',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                } else {
                  Get.snackbar(
                    'Failed',
                    'Product Creation Failed',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
              child: Text('Add Product'),
            ),

            Expanded(
              flex: 1,
              child: newProductProvider.when(
                data: (data) {
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final product = data[index];
                      return ListTile(
                        title: Text(product.title),
                        trailing: Text(product.price.toString()),
                        leading: Image.network(product.images[0]),

                      );
                    },
                  );
                },
                error: (err, st) {
                  return Center(child: Text('$err'));
                },
                loading: () => Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
