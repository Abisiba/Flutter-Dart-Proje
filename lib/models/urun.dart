class Urun {
  final int id;
  final String isim;
  final double fiyat;
  final String aciklama;
  final String resimUrl;
  final String kategori;
  bool favoriMi;

  Urun({
    required this.id,
    required this.isim,
    required this.fiyat,
    required this.aciklama,
    required this.resimUrl,
    required this.kategori,
    this.favoriMi = false,
  });

  factory Urun.fromJson(Map<String, dynamic> json) {
    return Urun(
      id: json['id'],
      isim: json['title'],
      fiyat: (json['price'] as num).toDouble() * 43,
      aciklama: json['description'],
      resimUrl: json['image'],
      kategori: json['category'],
    );
  }
}