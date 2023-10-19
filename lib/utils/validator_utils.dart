class ValidatorUtils {

 static bool isCampoValido(value) {
    if (value.isEmpty || double.tryParse(getValorSemFormatacao(value)) == null
        || double.parse(getValorSemFormatacao(value)) <= 0) {
      return false;
    }
    return true;
  }

  static String getValorSemFormatacao(val) {
    return val.replaceAll('.', '').replaceAll(',', '.');
  }
}
