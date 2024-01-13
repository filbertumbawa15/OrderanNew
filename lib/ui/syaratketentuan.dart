import 'package:flutter/material.dart';

class SyaratKetentuanWidget extends StatefulWidget {
  const SyaratKetentuanWidget({Key? key}) : super(key: key);

  @override
  State<SyaratKetentuanWidget> createState() => _SyaratKetentuanWidgetState();
}

class _SyaratKetentuanWidgetState extends State<SyaratKetentuanWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1F1EF),
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xFFB7B7B7),
            )),
      ),
      backgroundColor: const Color(0xFFF1F1EF),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/imgs/taslogo.png',
                width: 150,
                height: 150,
              ),
              const Text(
                "Syarat dan Ketentuan",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "1. HARGA BELUM TERMASUK BIAYA KAWAL (JIKA ADA) \n \n2. BELUM TERMASUK BIAYA BONGKAR MUAT DI LOKASI STUFFING / STRIPPING \n \n3. BERLAKU UNTUK LOKASI YANG DAPAT MASUK CONTAINER ATAU TRAILER TANPA ADA LARANGAN (TIDAK TERMASUK UANG KAWAL) \n \n4. MUATAN MAKSIMUM PETI KEMAS BESERTA ISINYA (BRUTTO) ADALAH 23 TON (20') & 26 TON (40'). \n \n5. FREETIME STORAGE DAN DEMURRAGE ADALAH 3 (TIGA) HARI DI TEMPAT TUJUAN (PEMBONGKARAN), APABILA LEBIH DARI 3 (TIGA) HARI MAKA SEGALA BIAYA DILUAR TANGGUNG JAWAB EKSPEDISI. \n \n6. EKSPEDISI TIDAK BERTANGGUNG JAWAB ATAS KERUGIAN AKIBAT FORCE MAJEUR (BENCANA ALAM), HURU - HARA, PERAMPOKAN, KERUSUHAN, PENJARAHAN / PEMBAJAKAN. \n \n7. EKSPEDISI TIDAK BERTANGGUNG JAWAB ATAS KEHILANGAN BARANG, KEKURANGAN, JIKA SEAL / PENGAMAN DALAM KEADAAN BAGUS. \n \n8. EKSPEDISI TIDAK BERTANGGUNG JAWAB ATAS PERUBAHAN KUALITAS BARANG DIKARENAKAN OLEH SIFAT BARANG ITU. \n \n9. DIANJURKAN PIHAK SHIPPER UNTUK MENGASURANSIKAN BARANGNYA DALAM KEADAAN ALL RISK WARE HOUSE TO WARE HOUSE. \n \n10. MUATAN TIDAK BOLEH BERAT SEBELAH, APABILA TERJADI MAKA SEGALA BIAYA DITANGGUNG PEMILIK BARANG. \n \n11.PEMILIK BARANG BERTANGGUNG JAWAB TERHADAP ISI MUATAN DARI AKIBAT HUKUM YANG TIMBUL DENGAN MEMBEBASKAN PERUSAHAAN PENGANGKUTAN DARI SEGALA INSTANSI YANG BERSANGKUTAN DAN BERSEDIA MENANGGUNG SEGALA BIAYA KERUGIAN YANG TIMBUL. \n \n12. PELUNASAN JASA EKSPEDISI PALING LAMBAT 1 (SATU) BULAN DARI TANGGAL KAPAL BERANGKAT SESUAI YANG TERCANTUM DI BL PELAYARAN. \n \n13. HARGA TIDAK MENGIKAT SEWAKTU WAKTU DAPAT BERUBAH.",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
