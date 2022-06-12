class Product {
  String? id, name, sellerId, description, category, imageUrl;
  var comments;
  double? price;
  Product(
      {this.id = "",
      this.name = "",
      this.price = 0.0,
      this.sellerId = "",
      this.description = "",
      this.comments = "",
      this.category = "",
      this.imageUrl});
}
