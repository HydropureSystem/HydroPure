class MarketItem {
  final String namaProduk;
  final int harga;
  final String hargaText;
  final String kategori;
  final String platform;
  final String tanggalScraping;
  final double progress;

  MarketItem({
    required this.namaProduk,
    required this.harga,
    required this.hargaText,
    required this.kategori,
    required this.platform,
    required this.tanggalScraping,
    required this.progress,
  });

  factory MarketItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return MarketItem(
      namaProduk: json['nama_produk'],
      harga: json['harga'],
      hargaText: json['harga_text'],
      kategori: json['kategori'],
      platform: json['platform'],
      tanggalScraping: json['tanggal_scraping'],
      progress: (json['progress'] as num)
          .toDouble(),
    );
  }
}