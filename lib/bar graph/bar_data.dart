import 'package:control_gastos1/bar%20graph/individual_bar.dart';

class BarData {
  final double monMounted;
  final double tueMounted;
  final double wedMounted;
  final double thurMounted;
  final double fryMounted;
  final double satMounted;
  final double sunMounted;
  BarData({
    required this.monMounted,
    required this.tueMounted,
    required this.wedMounted,
    required this.thurMounted,
    required this.fryMounted,
    required this.satMounted,
    required this.sunMounted,
  });

  List<IndividualBar> barData = [];
  void initializeBarData() {
    barData = [
      IndividualBar(x: 0, y: monMounted),
      IndividualBar(x: 1, y: tueMounted),
      IndividualBar(x: 2, y: wedMounted),
      IndividualBar(x: 3, y: thurMounted),
      IndividualBar(x: 4, y: fryMounted),
      IndividualBar(x: 5, y: satMounted),
      IndividualBar(x: 6, y: sunMounted),
    ];
  }
}
