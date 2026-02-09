import 'package:flutter/material.dart';
import 'package:favoriler_sayfasi/models/urun.dart';

class UrunDetaySayfasi extends StatefulWidget {
  final Urun urun;

  const UrunDetaySayfasi({super.key, required this.urun});

  @override
  State<UrunDetaySayfasi> createState() => _UrunDetaySayfasiState();
}

class _UrunDetaySayfasiState extends State<UrunDetaySayfasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.urun.isim),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'urun-resim-${widget.urun.id}',
              child: Container(
                width: double.infinity,
                height: 250,
                color: Colors.white,
                child: Image.network(
                  widget.urun.resimUrl,
                  fit: BoxFit.contain, 
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "₺${widget.urun.fiyat.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      Chip(
                        label: Text(widget.urun.kategori.toUpperCase()),
                        backgroundColor: Colors.teal.shade50,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.urun.isim,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Divider(height: 30),
                  const Text(
                    "Ürün Açıklaması",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.urun.aciklama,
                    style: const TextStyle(fontSize: 15, color: Colors.black87, height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.urun.favoriMi ? Colors.grey : Colors.teal,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          icon: Icon(
            widget.urun.favoriMi ? Icons.favorite : Icons.favorite_border,
            color: Colors.white,
          ),
          label: Text(
            widget.urun.favoriMi ? "FAVORİLERDEN ÇIKAR" : "FAVORİLERİME EKLE",
            style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            setState(() {
              widget.urun.favoriMi = !widget.urun.favoriMi;
            });
            
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(widget.urun.favoriMi 
                  ? "Favorilere eklendi!" 
                  : "Favorilerden çıkarıldı!"),
                duration: const Duration(seconds: 1),
              ),
            );
          },
        ),
      ),
    );
  }
}