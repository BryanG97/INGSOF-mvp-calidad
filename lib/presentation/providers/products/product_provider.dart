
import 'package:flutter_meedu/meedu.dart';
import 'package:mvp_calidad/presentation/controllers/product_controller.dart';

final productProvider = SimpleProvider(
  (_) => ProductController()
);