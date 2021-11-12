class CryptoExchange {
  CryptoExchange({
    required this.time,
    required this.assetIdBase,
    required this.assetIdQuote,
    required this.rate,
  });
  late final String time;
  late final String assetIdBase;
  late final String assetIdQuote;
  late final double rate;

  CryptoExchange.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    assetIdBase = json['asset_id_base'];
    assetIdQuote = json['asset_id_quote'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['time'] = time;
    _data['asset_id_base'] = assetIdBase;
    _data['asset_id_quote'] = assetIdQuote;
    _data['rate'] = rate;
    return _data;
  }
}
