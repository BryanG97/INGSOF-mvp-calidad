import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:mvp_calidad/domain/entities/product_Entity.dart';
import 'package:mvp_calidad/domain/entities/statistical_values_entity.dart';
import 'package:mvp_calidad/presentation/providers/products/product_provider.dart';

class ProductAnalyticsScreen extends StatelessWidget {
  static const name = 'product-analytics-screen';

  const ProductAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    //TO LOAD STATISTICAL VALUES
    productProvider.read.getStatisticalValuesToShow();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 20, right: 20),

        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Análisis estadístico.',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 49, 110, 190),),
            ),

            Consumer(
              builder: (_, ref,child){
                final data = ref.watch(productProvider);
                final checkListValues = data.getCheckListValues;
                final statisticalValues = data.getStatisticalValues;

                return Expanded(
                  child: ListView.builder(
                    itemCount: checkListValues!.length,
                    itemBuilder: (_, int index) {
                      final item = checkListValues[index];
                      final value = statisticalValues!.firstWhere((element) => element.statisticalId == item.itemValue);

                      return StatisticalGraphs(
                        item: item,
                        statisticalValues: value,
                      );

                    }
                  ),
                );

              }
            
            ),
            
          ],

        ),
      ),
    );
  }
}

class StatisticalGraphs extends StatelessWidget {
  final ProductCheckListEntity item;
  final StatisticalValuesEntity statisticalValues;

  const StatisticalGraphs({
    super.key,
    required this.item,
    required this.statisticalValues,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.itemName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AspectRatio(
                  aspectRatio: 1.3,
                  child:PieChart(
                    PieChartData(
                      sections: _generatePieChartSections(),
                    )
                  ),
                ),

              ],
            ),

          );
  
  }

  List<PieChartSectionData> _generatePieChartSections() {

    return [
      
      PieChartSectionData(
        value: statisticalValues.yesValue.value,
        color: statisticalValues.yesValue.color,
        title: '${statisticalValues.yesValue.title} \n ${statisticalValues.yesValue.value} %',
        radius: 50,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        value: statisticalValues.noValue.value,
        color: statisticalValues.noValue.color,
        title: '${statisticalValues.noValue.title} \n ${statisticalValues.noValue.value} %',
        radius: 50,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      

    ];

  }

}