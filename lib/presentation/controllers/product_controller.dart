
import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:mvp_calidad/domain/entities/product_Entity.dart';

class ProductController extends SimpleNotifier {

  List<ProductEntity> _productList = [];
  List<ProductCheckListEntity> _checkListList = [];
  List<ProductCheckListEntity> _checkListToAdd = [];

  //GETTERS
  List<ProductEntity>? get getProductList => _productList; 

  List<ProductCheckListEntity>? get getCheckListValues => _checkListList; 

  List<ProductCheckListEntity>? get getCheckListToAdd => _checkListToAdd; 

  //SETTERS
  set setProductToList(ProductEntity product){
    _productList.add(product);
  }
  
  set setValuesToCheckList(ProductCheckListEntity checkListValue){
    _checkListList.add(checkListValue);
  }
  
  set setValuesToCheckListToAdd(ProductCheckListEntity checkListValue){
    _checkListToAdd.add(checkListValue);
  }

  /// To load product list
  getInitialProducts(){
    _productList = [];
    final ProductEntity product1 = ProductEntity(
      productId: 'M1', 
      productName: 'BRAZO HIDRÁULICO', 
      productDescription: 'Brazo hidráulico para ensamblaje de vehículos.', 
      productImage: 'assets/images/brazo.jpg'
    );
    
    final ProductEntity product2 = ProductEntity(
      productId: 'M2', 
      productName: 'SOLDADORA INDUSTRIAL', 
      productDescription: 'Utilizadas para unir piezas metálicas.', 
      productImage: 'assets/images/soldadora.jpg'
    );
    
    final ProductEntity product3 = ProductEntity(
      productId: 'M3', 
      productName: 'TRANSPORTADORAS DE ENSAMBLAJE', 
      productDescription: 'Sistemas mecanicos para mover vehículos.', 
      productImage: 'assets/images/banda.jpg'
    );

    _productList.add(product1);
    _productList.add(product2);
    _productList.add(product3);

    // INIT CHECK LIST VALUES
    getCheckList();

  }

  /// To load checklist items
  getCheckList(){
    _checkListList = [];
    final ProductCheckListEntity value1 = ProductCheckListEntity(
      itemName: 'Inspección visual de componentes y estructuras.',
      itemValue: '1'
    );
    final ProductCheckListEntity value2 = ProductCheckListEntity(
      itemName: 'Verificación de ruidos o vibraciones anormales.',
      itemValue: '2'
    );
    final ProductCheckListEntity value3 = ProductCheckListEntity(
      itemName: 'Ausencia de desgastes, roturas o conexiones sueltas.',
      itemValue: '3'
    );
    final ProductCheckListEntity value4 = ProductCheckListEntity(
      itemName: 'Etiquetas de advertencia legibles y en buen estado.',
      itemValue: '4'
    );

    _checkListList.add(value1);
    _checkListList.add(value2);
    _checkListList.add(value3);
    _checkListList.add(value4);

  }

  /// To add checklist values to add
  createCheckListArrayToAdd(ProductCheckListEntity checkItem){
    _checkListToAdd.add(checkItem);
    debugPrint('Chek list to add: $_checkListToAdd');
  }

  ///ADD CHECKLIST TO PRODUCT
  addCheckListToProduct(ProductEntity product){
    try{
      ProductEntity productFind = _productList.firstWhere((element) => element.productId == product.productId);
      productFind.productCheckList = _checkListToAdd;
      _checkListToAdd = [];
    }catch(e){
      debugPrint('Product with id ${product.productId} not found.');
    }
  }

}