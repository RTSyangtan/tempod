import 'category.dart';

class ProductModel {
  final int id;
  final String title;
  final String slug;
  final int price;
  final String description;
  final Category category;
  final List<String> images;

  ProductModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.price,
    required this.description,
    required this.category,
    required this.images
  });

  Map<String,dynamic> toJson(){
    return <String,dynamic>{
      'title':title,
      'price':price,
      'description':description,
      'image':images

    };
  }

  factory ProductModel.fromJson(Map<String,dynamic> json){
    return  ProductModel
      (id: json['id'],
        title: json['title'],
        slug: json['slug'],
        price: json['price'],
        description: json['description'],
        category: Category.fromJson(json['category']),
        images: List<String>.from(json['images']));
  }
}