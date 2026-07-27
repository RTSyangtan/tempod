class Category{
  final int id;
  final String name;
  final String image;
  final String slug;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.slug
  });

  factory Category.fromJson(Map<String,dynamic> json){
    return Category(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        slug: json['slug']);
  }

}