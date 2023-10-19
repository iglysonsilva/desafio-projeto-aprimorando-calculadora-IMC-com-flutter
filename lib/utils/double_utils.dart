class DoubleUtils {
  double transformaStringEmNum(val) {
    if (val == null || val == '') {
      return 0;
    }
    return double.parse(val.toString().replaceAll("R\$", '').replaceAll('.', '').replaceAll(',', '.'));
  }
}
