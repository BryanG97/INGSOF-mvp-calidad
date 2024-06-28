
import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:mvp_calidad/domain/entities/product_Entity.dart';
import 'package:mvp_calidad/domain/entities/statistical_values_entity.dart';

class ProductController extends SimpleNotifier {

  List<ProductEntity> _productList = [];
  List<ProductCheckListEntity> _checkListList = [];
  List<ProductCheckListEntity> _checkListToAdd = [];
  List<StatisticalValuesEntity> _statisticalValues = [];

  //GETTERS
  List<ProductEntity>? get getProductList => _productList; 

  List<ProductCheckListEntity>? get getCheckListValues => _checkListList; 

  List<ProductCheckListEntity>? get getCheckListToAdd => _checkListToAdd;

  List<StatisticalValuesEntity>? get getStatisticalValues => _statisticalValues; 

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
  
  set setStatisticalValue(StatisticalValuesEntity statisticalValue){
    _statisticalValues.add(statisticalValue);
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
    
    final ProductEntity product4 = ProductEntity(
      productId: 'M4', 
      productName: 'ATORNILLADORES AUTOMÁTICOS', 
      productDescription: 'Para apretar tornillos y pernos con precisión.', 
      productImage: 'assets/images/atornilladora.jpg'
    );

    final ProductEntity product5 = ProductEntity(
      productId: 'M5', 
      productName: 'PRENSA HIDRÁULICA', 
      productDescription: 'Utilizadas para dar forma a las piezas metálicas mediante estampado.', 
      productImage: 'assets/images/prensa.jpg'
    );
    final ProductEntity product6 = ProductEntity(
      productId: 'M6', 
      productName: 'AGV', 
      productDescription: 'Vehículos guiados automáticamente que transportan piezas y ensamblajes a lo largo de la línea de producción.', 
      productImage: 'assets/images/avg.jpg'
    );
    final ProductEntity product7 = ProductEntity(
      productId: 'M7', 
      productName: 'CORTADORA LASER', 
      productDescription: 'Utilizadas para cortar con precisión piezas metálicas de diversas formas y tamaños.', 
      productImage: 'assets/images/laser.jpg'
    );
    
    final ProductEntity product8 = ProductEntity(
      productId: 'M8', 
      productName: 'INFLADOR DE LLANTAS', 
      productDescription: 'Utilizadas para inflar llantas con nitrógeno', 
      productImage: 'assets/images/inflador.jpg'
    );

    _productList.add(product1);
    _productList.add(product2);
    _productList.add(product3);
    _productList.add(product4);
    _productList.add(product5);
    _productList.add(product6);
    _productList.add(product7);
    _productList.add(product8);

    // INIT CHECK LIST VALUES
    getCheckList();

    notify();
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

    notify();
  }

  // METHOD TO GENERATE STATISTICAL VALUES
  getStatisticalValuesToShow(){
    _statisticalValues = [];
    String yesTitle = 'SI';
    String noTitle = 'NO';
    Color yesColor= Colors.green;
    Color noColor = Colors.red;

    for (var checkListItem in _checkListList) {

      StatisticalValuesEntity statisticalValue;
      double yesValue = 0;
      double noValue = 0;

      for(var product in _productList){

        if(product.productCheckList != null){
          yesValue += (product.productCheckList?.where((element) => 
            element.itemValue == checkListItem.itemValue).length?? 0).toDouble();
        }

      }

      noValue = _productList.length - yesValue;

      //Get values in porcentage
      yesValue = (yesValue/_productList.length) * 100;
      noValue = (noValue/_productList.length) * 100;

      //Build statistical value object
      statisticalValue = StatisticalValuesEntity(
        statisticalId: checkListItem.itemValue,
        yesValue: StatisticalObjetcEntity(
          title: yesTitle,
          color: yesColor,
          value: yesValue
        ),
        noValue: StatisticalObjetcEntity(
          title: noTitle,
          color: noColor,
          value: noValue
        ),
      );

      _statisticalValues.add(statisticalValue);

    }

  }

}