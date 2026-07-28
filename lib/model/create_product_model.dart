class CreateProductModel{
  final String title;
  final int price;
  final String description;
  final int categoryId;
  final List<String> images;

  CreateProductModel({
   required this.title,
   required this.price,
   required this.description,
   required this.categoryId,
   required this.images
});

  Map<String,dynamic> toJson(){
    return <String,dynamic> {
      'title':title,
      'price':price,
      'description': description,
      'categoryId':categoryId,
      'images':images
    };
  }

  factory CreateProductModel.fromJson(Map<String,dynamic> json){
    return CreateProductModel(
        title: json['title'],
        price: json['price'],
        description: json['description'],
        categoryId: json['categoryId'],
        images: json['images']);
  }
}