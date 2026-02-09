import 'package:flutter/material.dart';
import 'package:favoriler_sayfasi/models/urun.dart';
import 'package:favoriler_sayfasi/components/urun_karti.dart';
import 'package:favoriler_sayfasi/services/urun_service.dart';
import 'package:favoriler_sayfasi/views/favoriler_sayfasi.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  final UrunService _servis = UrunService();
  List<Urun> tumUrunler = [];
  List<Urun> filtrelenmisUrunler = [];
  String seciliKategori = "Hepsi";
  bool yukleniyor = true;

  final List<String> kategoriListesi = ["Hepsi", "Elektronik", "Takı & Aksesuar", "Erkek Giyim", "Kadın Giyim"];

  final Map<String, String> kategoriMap = {
    "electronics": "Elektronik",
    "jewelery": "Takı & Aksesuar",
    "men's clothing": "Erkek Giyim",
    "women's clothing": "Kadın Giyim",
  };

  @override
  void initState() {
    super.initState();
    _verileriYukle();
  }

  void _verileriYukle() async {
    final veriler = await _servis.tumUrunleriGetir();
    setState(() {
      tumUrunler = veriler;
      filtrelenmisUrunler = tumUrunler;
      yukleniyor = false;
    });
  }

  void _filtrele(String kategori) {
    setState(() {
      seciliKategori = kategori;
      if (kategori == "Hepsi") {
        filtrelenmisUrunler = tumUrunler;
      } else {
        filtrelenmisUrunler = tumUrunler.where((u) {
          return kategoriMap[u.kategori] == kategori;
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trend Mağaza"),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              final favoriler = tumUrunler.where((u) => u.favoriMi).toList();
              Navigator.push(context, MaterialPageRoute(builder: (context) => FavorilerSayfasi(favoriler: favoriler)));
            },
          )
        ],
      ),
      body: yukleniyor
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: kategoriListesi.map((kat) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: ChoiceChip(
                        label: Text(kat, style: const TextStyle(fontSize: 11)),
                        selected: seciliKategori == kat,
                        onSelected: (_) => _filtrele(kat),
                        selectedColor: Colors.teal,
                        labelStyle: TextStyle(color: seciliKategori == kat ? Colors.white : Colors.black),
                      ),
                    )).toList(),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(4),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, 
                      childAspectRatio: 0.55,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                    ),
                    itemCount: filtrelenmisUrunler.length,
                    itemBuilder: (context, index) {
                      return UrunKarti(
                        urun: filtrelenmisUrunler[index],
                        onFavoriToggle: () => setState(() {
                          filtrelenmisUrunler[index].favoriMi = !filtrelenmisUrunler[index].favoriMi;
                        }),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}