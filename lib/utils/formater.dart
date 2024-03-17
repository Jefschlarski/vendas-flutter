import 'package:intl/intl.dart';

class Formarter {
  static String formatarParaReais(double valor) {
    final formatadorReais =
        NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return formatadorReais.format(valor);
  }
}
