
class ProductEntity {
  final String productId;
  final String productName;
  final String productDescription;
  final String productImage;
  final List<ProductCheckListEntity>? productCheckList;
  
  ProductEntity({
    required this.productId,
    required this.productName, 
    required this.productDescription, 
    required this.productImage, 
    this.productCheckList, 
  });

}

class ProductCheckListEntity {
  final String productId;
  final String productCheck;

  ProductCheckListEntity({
    required this.productId,
    required this.productCheck,
  });

}
