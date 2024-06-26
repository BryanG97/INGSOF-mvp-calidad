import 'package:flutter/material.dart';

import 'package:flutter_meedu/ui.dart';
import 'package:mvp_calidad/domain/entities/product_Entity.dart';
import 'package:mvp_calidad/presentation/providers/products/product_provider.dart';
import 'package:mvp_calidad/presentation/screens/product_check_list/product_check_list_screen.dart';

class ProductListScreen extends StatelessWidget {
  static const name = 'product-list-screen';

  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ProductsList(),
    );
  }
}

class ProductsList extends StatefulWidget {
  const ProductsList({super.key,});

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {

    productProvider.read.getInitialProducts();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 184, 194, 194),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => Future.sync(
            () => productProvider.read.getInitialProducts(),
          ),
          
          child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
            child: Column(
              children: [
                const Row(
                  children: [
                    Text(
                      "Productos",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    )
                  ],
                ),

                const SizedBox(height: 15),

                Expanded(
                  child: Consumer(
                    builder: (context, ref, child){
                      final data = ref.watch(productProvider);
                      final productList = data.getProductList;

                      if (productList != null && productList.isNotEmpty) {
                        return ListView.builder(
                          controller: scrollController,
                          itemCount: productList.length,
                          itemBuilder: (context, index) {
                            final product = productList[index];

                            /* return const ListTile(
                              title:  Text('Titulo'),
                              subtitle:  Text('Descripcion'),
                            ); */

                            return InkWell(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ProductChecklistScreen(
                                        product: product,
                                      );
                                    },
                                  ),
                                );
                              },

                              child: ProductCard(
                                productEntity: product,
                                index: index + 1,
                              ),

                            );

                          },
                        );
                      } else if (productList != null && productList.isEmpty) {
                        return const Center(
                          child: Text('No hay productos disponibles.'),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                    }
                  ),
                ),

              ]
            ),
          ),
        ), 
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductEntity productEntity;
  final int index;

  const ProductCard({
    super.key,
    required this.productEntity,
    required this.index
  });

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListTile(
            
            leading: SizedBox(
              height: 200,
              child: Column(
                children: [
                  Flexible(
                    child: Image.asset(productEntity.productImage, height: 100, width: 100),
                  ),
                ],
              ),
            ),
            title: Text(
              productEntity.productName,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),

            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Text(
                  productEntity.productDescription,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),

          ),

        ),
      ),

    );

  }
}