import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:mvp_calidad/domain/entities/check_list_entity.dart';
import 'package:mvp_calidad/domain/entities/product_Entity.dart';
import 'package:mvp_calidad/presentation/providers/products/product_provider.dart';

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
                        return ItemCheckListWidget(
                          item: item,
                        );
                      },
                    ),
                  );

                }
              ),

            ]
          ),
        )
      ),
    );
  }
}

class ItemCheckListWidget extends StatefulWidget {
  final CheckListEntity item;
  const ItemCheckListWidget({
    super.key,
    required this.item,
  });

  @override
  State<ItemCheckListWidget> createState() => _ItemCheckListWidgetState();
}

class _ItemCheckListWidgetState extends State<ItemCheckListWidget> {
  bool activeSelect = false;

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
              enabled: true,
              value: activeSelect,
              onChanged: (value) {
                setState(() {
                  activeSelect = value!;
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