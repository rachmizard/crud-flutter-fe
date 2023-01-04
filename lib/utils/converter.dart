import 'package:intl/intl.dart';

convertIntToRupiah(int value) {
  final formatter = NumberFormat.currency(locale: 'id', symbol: 'Rp ');
  return formatter.format(value);
}
