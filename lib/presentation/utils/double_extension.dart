extension DoubleExtension on double {
  String prettify({int i = 2}) =>
      this.toStringAsFixed(i).replaceFirst(RegExp(r'\.?0*$'), '');
}
