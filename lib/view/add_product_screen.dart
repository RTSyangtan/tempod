import 'package:flutter/material.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final titleCtrl = TextEditingController();
    final priceCtrl = TextEditingController();
    final descriptionCtrl = TextEditingController();
    final categoryCtrl = TextEditingController();
    final imageCtrl = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('Create Product'),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 10,
          children: [
            TextFormField(
              controller: titleCtrl,
          decoration: InputDecoration(hintText: 'Title',border: OutlineInputBorder())),
            TextFormField(
              controller: priceCtrl,
                decoration: InputDecoration(hintText: 'Price',border: OutlineInputBorder())),
            TextFormField(
              controller: descriptionCtrl,
                decoration: InputDecoration(hintText: 'Description',border: OutlineInputBorder())),
            TextFormField(
              controller: categoryCtrl,
                decoration: InputDecoration(hintText: 'Category',border: OutlineInputBorder())),
            TextFormField(
              controller: imageCtrl,
                decoration: InputDecoration(hintText: 'Image',border: OutlineInputBorder())),
            ElevatedButton(onPressed: (){

            }, child: Text('Add Product'))

          ],
        ),
      ),
    );
  }
}
