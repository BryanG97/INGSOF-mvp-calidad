
class ProductEntity {
  final String productId;
  final String productName;
  final String productDescription;
  final String productImage;
  List<ProductCheckListEntity>? productCheckList;
  
  ProductEntity({
    required this.productId,
    required this.productName, 
    required this.productDescription, 
    required this.productImage, 
    this.productCheckList, 
  });

}

class ProductCheckListEntity {
  String itemName;
  String itemValue;

  ProductCheckListEntity({
    required this.itemName, 
    required this.itemValue, 
  });

}
