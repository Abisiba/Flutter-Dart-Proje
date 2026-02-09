import 'package:flutter/material.dart';
import 'package:favoriler_sayfasi/models/urun.dart';
import 'package:favoriler_sayfasi/views/urun_detay_sayfasi.dart';

class UrunKarti extends StatelessWidget {
  final Urun urun;
  final VoidCallback onFavoriToggle;

  const UrunKarti({
    super.key,
    required this.urun,
    required this.onFavoriToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UrunDetaySayfasi(urun: urun),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 5,
              child: Hero(
                tag: 'urun-resim-${urun.id}',
                child: Image.network(
                  urun.resimUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => 
                      const Icon(Icons.broken_image, color: Colors.grey),
                ),
              ),
            ),
            
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      urun.isim,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "₺${urun.fiyat.toStringAsFixed(2)}",
                      style: const TextStyle(
                        color: Colors.green, 
                        fontWeight: FontWeight.bold, 
                        fontSize: 11
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            urun.kategori,
                            style: const TextStyle(fontSize: 8, color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        GestureDetector(
                          onTap: onFavoriToggle,
                          child: Icon(
                            urun.favoriMi ? Icons.favorite : Icons.favorite_border,
                            color: urun.favoriMi ? Colors.red : Colors.grey,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}