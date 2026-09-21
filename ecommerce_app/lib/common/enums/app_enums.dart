enum OrderStatus {
  pending, confirmed, processing, shipped, delivered, cancelled;
  
  String get label {
    switch (this) {
      case OrderStatus.pending: return 'Pending';
      case OrderStatus.confirmed: return 'Confirmed';
      case OrderStatus.processing: return 'Processing';
      case OrderStatus.shipped: return 'Shipped';
      case OrderStatus.delivered: return 'Delivered';
      case OrderStatus.cancelled: return 'Cancelled';
    }
  }
  
  static OrderStatus fromString(String value) {
    return OrderStatus.values.firstWhere((e) => e.name == value, orElse: () => OrderStatus.pending);
  }
}

enum PaymentStatus {
  pending, paid, failed, refunded;
  String get label { switch(this) { case PaymentStatus.pending: return 'Pending'; case PaymentStatus.paid: return 'Paid'; case PaymentStatus.failed: return 'Failed'; case PaymentStatus.refunded: return 'Refunded'; } }
  static PaymentStatus fromString(String v) => PaymentStatus.values.firstWhere((e) => e.name == v, orElse: () => PaymentStatus.pending);
}

enum ProductStatus {
  active, outOfStock, archived;
  String get label { switch(this) { case ProductStatus.active: return 'Active'; case ProductStatus.outOfStock: return 'Out of Stock'; case ProductStatus.archived: return 'Archived'; } }
  static ProductStatus fromString(String v) => ProductStatus.values.firstWhere((e) => e.name == v, orElse: () => ProductStatus.active);
}

enum UserRole {
  customer, admin;
  String get label => name[0].toUpperCase() + name.substring(1);
  static UserRole fromString(String v) => UserRole.values.firstWhere((e) => e.name == v, orElse: () => UserRole.customer);
}
