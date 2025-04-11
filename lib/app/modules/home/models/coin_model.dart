class CoinModel {
  final String id;
  final String name;
  final String image;
  final double currentPrice;

  CoinModel({
    required this.id,
    required this.name,
    required this.image,
    required this.currentPrice,
  });

  factory CoinModel.fromJson(Map<String, dynamic> json) {
    return CoinModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      currentPrice: json['current_price'].toDouble(),
    );
  }
}
