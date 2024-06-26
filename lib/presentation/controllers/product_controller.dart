
import 'package:flutter_meedu/meedu.dart';
import 'package:mvp_calidad/domain/entities/check_list_entity.dart';
import 'package:mvp_calidad/domain/entities/product_Entity.dart';

class ProductController extends SimpleNotifier {

  List<ProductEntity> _productList = [];
  List<CheckListEntity> _checkListList = [];

  //GETTERS
  List<ProductEntity>? get getProductList => _productList; 

  List<CheckListEntity>? get getCheckListValues => _checkListList; 

  //SETTERS
  set setProductToList(ProductEntity product){
    _productList.add(product);
  }
  
  set setValuesToCheckList(CheckListEntity checkListValue){
    _checkListList.add(checkListValue);
  }

  getInitialProducts(){
    _productList = [];
    final ProductEntity product1 = ProductEntity(
      productId: '1', 
      productName: 'BRAZO HIDRÁULICO', 
      productDescription: 'Brazo hidráulico para ensamblaje de vehículos.', 
      productImage: 'assets/images/brazo.jpg'
    );
    
    final ProductEntity product2 = ProductEntity(
      productId: '2', 
      productName: 'SOLDADORA INDUSTRIAL', 
      productDescription: 'Utilizadas para unir piezas metálicas.', 
      productImage: 'assets/images/soldadora.jpg'
    );
    
    final ProductEntity product3 = ProductEntity(
      productId: '3', 
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

  getCheckList(){
    _checkListList = [];
    final CheckListEntity value1 = CheckListEntity(
      itemName: 'Inspección visual de componentes y estructuras.',
      itemValue: '1'
    );
    final CheckListEntity value2 = CheckListEntity(
      itemName: 'Verificación de ruidos o vibraciones anormales.',
      itemValue: '2'
    );
    final CheckListEntity value3 = CheckListEntity(
      itemName: 'Ausencia de desgastes, roturas o conexiones sueltas.',
      itemValue: '3'
    );
    final CheckListEntity value4 = CheckListEntity(
      itemName: 'Etiquetas de advertencia legibles y en buen estado.',
      itemValue: '4'
    );

    _checkListList.add(value1);
    _checkListList.add(value2);
    _checkListList.add(value3);
    _checkListList.add(value4);

  }

}