class CartProductDto {
  final int productId;
  final int amount;

  CartProductDto({required this.productId, required this.amount});

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'amount': amount,
    };
  }
}
