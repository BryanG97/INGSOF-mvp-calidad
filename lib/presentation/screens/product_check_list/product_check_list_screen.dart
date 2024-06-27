import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:mvp_calidad/domain/entities/product_Entity.dart';
import 'package:mvp_calidad/presentation/providers/products/product_provider.dart';
import 'package:mvp_calidad/presentation/widgets/shared/custom_button.dart';
import 'package:mvp_calidad/presentation/widgets/shared/custom_toast.dart';

class ProductChecklistScreen extends StatefulWidget {
  static const name = 'product-list-screen';

  final ProductEntity product;

  const ProductChecklistScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductChecklistScreen> createState() => _ProductChecklistScreenState();
}

class _ProductChecklistScreenState extends State<ProductChecklistScreen> {
  @override
  Widget build(BuildContext context) {
    bool editable = true;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 184, 194, 194),
        body: Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Column(
            children: [

              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  const Text(
                    'REGRESAR',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              Text(
                widget.product.productName,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              Consumer(
                builder: (_, ref,child){
                  final data = ref.watch(productProvider);
                  final checkListValues = data.getCheckListValues;

                  return Expanded(
                    child: ListView.builder(
                      itemCount: checkListValues!.length,
                      itemBuilder: (_, int index) {
                        final item = checkListValues[index];

                        bool isChecked = false;
                  
                        final productCheckList = widget.product.productCheckList;
                        editable = productCheckList == null? true : false;

                        if(!editable){
                          try{
                            final verify = productCheckList!.where((element) => element.itemValue == item.itemValue).toList();
                            isChecked = verify.isNotEmpty;
                          }catch(e){
                            isChecked = false;
                          }
                        }

                        return ItemCheckListWidget(
                          item: item,
                          isEnabled: editable,
                          isChecked: isChecked,
                        );
                      },
                    ),
                  );

                }
              ),

            ]
          ),
        ),
        
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child:  Consumer(
            builder: (_, ref, wid){
              final data = ref.watch(productProvider);

              bool enabled = true;
              if(widget.product.productCheckList != null){
                enabled = false;
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    label: 'Guardar', 
                    color: enabled? const Color(0xFF338A8A) :Colors.grey,
                    onTap: enabled? () async {
                      data.addCheckListToProduct(widget.product);
                      customToast(
                        seconds: 3,
                        context: context,
                        icon: Icons.error,
                        width: MediaQuery.of(context).size.width * 0.7,
                        color: const Color.fromARGB(255, 36, 190, 36),
                        text: 'Se guardó la información exitosamente.',
                        radius: 20,
                      );
                      Navigator.of(context).pop();
                    } :() => 
                      customToast(
                        seconds: 3,
                        context: context,
                        icon: Icons.error,
                        width: MediaQuery.of(context).size.width * 0.7,
                        color: const Color.fromARGB(255, 40, 115, 212),
                        text: 'El checklist no puede ser editado.',
                        radius: 20,
                      )

                  ),
                ],
              );
            }
          ),
        ),

      ),
    );
  }
}

class ItemCheckListWidget extends StatefulWidget {
  final ProductCheckListEntity item;
  final bool isEnabled;
  final bool isChecked;

  const ItemCheckListWidget({
    super.key,
    required this.item,
    required this.isEnabled,
    required this.isChecked
  });

  @override
  State<ItemCheckListWidget> createState() => _ItemCheckListWidgetState();
}

class _ItemCheckListWidgetState extends State<ItemCheckListWidget> {
  bool activeSelect = false;

  @override
  void initState(){
    activeSelect = widget.isChecked;
  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      alignment: Alignment.center,
      height: (MediaQuery.of(context).size.height) * 0.1,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          SizedBox(
            width: 330,
            child: CheckboxListTile(
              enabled: widget.isEnabled,
              value: activeSelect,
              onChanged: (value) {
                setState(() {
                  activeSelect = value!;
                  productProvider.read.createCheckListArrayToAdd(widget.item);
                });
              },

              title: Text(
                widget.item.itemName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),

        ]
      ),

    );
  }
}