class CurrencyHelper {
  CurrencyHelper._();

  static String format(double amount) {
    String val = amount.toStringAsFixed(2);
    final parts = val.split('.');
    String integerPart = parts[0];
    final decimalPart = parts[1];
    
    String result = '';
    int count = 0;
    for (int i = integerPart.length - 1; i >= 0; i--) {
      if (count > 0 && count % 3 == 0) {
        result = ',$result';
      }
      result = integerPart[i] + result;
      count++;
    }
    
    return '\$$result.$decimalPart';
  }

  static String formatCompact(double amount) {
    if (amount >= 1000000000) {
      return '\$${(amount / 1000000000).toStringAsFixed(1)}B';
    } else if (amount >= 1000000) {
      return '\$${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return '\$${(amount / 1000).toStringAsFixed(1)}K';
    }
    return '\$${amount.toStringAsFixed(amount.truncateToDouble() == amount ? 0 : 2)}';
  }
}
