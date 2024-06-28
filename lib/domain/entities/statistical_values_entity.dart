import 'package:flutter/material.dart';

class StatisticalValuesEntity {
  final String statisticalId;
  final StatisticalObjetcEntity yesValue;
  final StatisticalObjetcEntity noValue;
  
  StatisticalValuesEntity({
    required this.statisticalId,
    required this.yesValue,
    required this.noValue,
  });

}

class StatisticalObjetcEntity {
  final double value;
  final Color color;
  final String title;
  
  StatisticalObjetcEntity({
    required this.value,
    required this.color,
    required this.title,
  });

}