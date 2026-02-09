import 'package:flutter/material.dart';
import 'package:favoriler_sayfasi/models/urun.dart';

class FavorilerSayfasi extends StatefulWidget {
  final List<Urun> favoriler;
  const FavorilerSayfasi({super.key, required this.favoriler});

  @override
  State<FavorilerSayfasi> createState() => _FavorilerSayfasiState();
}

class _FavorilerSayfasiState extends State<FavorilerSayfasi> {
  @override
  Widget build(BuildContext context) {
    double toplam = widget.favoriler.fold(0, (sum, item) => sum + item.fiyat);

    return Scaffold(
      appBar: AppBar(title: const Text("Favorilerim"), backgroundColor: Colors.teal, foregroundColor: Colors.white),
      body: widget.favoriler.isEmpty
          ? const Center(child: Text("Favori listeniz boş."))
          : ListView.builder(
              itemCount: widget.favoriler.length,
              itemBuilder: (context, index) {
                final urun = widget.favoriler[index];
                return Dismissible(
                  key: ValueKey(urun.id),
                  direction: DismissDirection.endToStart,
                  background: Container(color: Colors.red, alignment: Alignment.centerRight, padding: const EdgeInsets.only(right: 20), child: const Icon(Icons.delete, color: Colors.white)),
                  onDismissed: (dir) => setState(() {
                    urun.favoriMi = false;
                    widget.favoriler.removeAt(index);
                  }),
                  child: ListTile(
                    leading: Image.network(urun.resimUrl, width: 40),
                    title: Text(urun.isim, style: const TextStyle(fontSize: 13)),
                    subtitle: Text("₺${urun.fiyat.toStringAsFixed(2)}"),
                  ),
                );
              },
            ),
      bottomNavigationBar: widget.favoriler.isEmpty ? null : Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Toplam:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text("₺${toplam.toStringAsFixed(2)}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal)),
            ],
          ),
        ),
      ),
    );
  }
}