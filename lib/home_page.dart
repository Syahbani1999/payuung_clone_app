// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payuung_clone_app/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isPayungPribadi = true;

  void switchPayuungIsPribadi(bool value) {
    setState(() {
      isPayungPribadi = value;
    });
  }

  bool fullExtend = false;

  void fullExtended(double currentSize, double extent) {
    setState(() {
      if (currentSize == extent) {
        fullExtend = true;
      } else {
        fullExtend = false;
      }
    });
  }

  var produkKeuangan = [
    {
      'icon': Icons.person_add_alt_1_rounded,
      'title': 'Urun',
    },
    {
      'icon': Icons.person_4_rounded,
      'title': 'Pembiayaan Porsi Haji',
    },
    {
      'icon': Icons.document_scanner_outlined,
      'title': 'Financial Check up',
    },
    {
      'icon': Icons.car_repair_outlined,
      'title': 'Asuransi Mobil',
    },
    {
      'icon': Icons.home_work_outlined,
      'title': 'Asuransi Properti',
    },
  ];

  var kategoriPilihan = [
    {
      'icon': Icons.beach_access_rounded,
      'title': 'Hobi',
    },
    {
      'icon': Icons.card_giftcard_rounded,
      'title': 'Merchandise',
    },
    {
      'icon': Icons.heart_broken_rounded,
      'title': 'Gaya Hidup Sehat',
    },
    {
      'icon': Icons.connect_without_contact_rounded,
      'title': 'Konseling dan Rohani',
    },
    {
      'icon': Icons.co_present_rounded,
      'title': 'Self Development',
    },
    {
      'icon': Icons.credit_card_outlined,
      'title': 'Perencanaan Keuangan',
    },
    {
      'icon': Icons.medical_information,
      'title': 'Konsultasi Medis',
    },
    {
      'icon': Icons.more_horiz_rounded,
      'title': 'Lihat Semua',
    },
  ];

  var exploreWellness = [
    {
      'icon':
          'https://seeklogo.com/images/I/indomaret-logo-DBC7AF66C5-seeklogo.com.png',
      'title': 'Voucher Digital Indomaret Rp 25.000',
      'price': 25000,
      'discount': 0,
    },
    {
      'icon':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/H%26M-Logo.svg/709px-H%26M-Logo.svg.png',
      'title': 'Voucher Digital H&M Rp 100.000',
      'price': 100000,
      'discount': 3000,
    },
    {
      'icon':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/H%26M-Logo.svg/709px-H%26M-Logo.svg.png',
      'title': 'Voucher Grab Transport Rp 20.000',
      'price': 20000,
      'discount': 0,
    },
    {
      'icon':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/H%26M-Logo.svg/709px-H%26M-Logo.svg.png',
      'title': 'Voucher Digital Excelso Rp 50.000',
      'price': 50000,
      'discount': 2000,
    },
    {
      'icon':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/H%26M-Logo.svg/709px-H%26M-Logo.svg.png',
      'title': 'Voucher Digital Grab Transport Rp 50.000',
      'price': 50000,
      'discount': 3000,
    },
    {
      'icon':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/H%26M-Logo.svg/709px-H%26M-Logo.svg.png',
      'title': 'Voucher Digital Bakmi GM Rp 100.000',
      'price': 100000,
      'discount': 5000,
    },
  ];

  var navBar = [
    {
      'icon': Icons.home_outlined,
      'title': 'Beranda',
    },
    {
      'icon': Icons.search_outlined,
      'title': 'Cari',
    },
    {
      'icon': Icons.shopping_cart_outlined,
      'title': 'Keranjang',
    },
    {
      'icon': Icons.list_alt_sharp,
      'title': 'Daftar Transaksi',
    },
    {
      'icon': Icons.card_giftcard_outlined,
      'title': 'Voucher Saya',
    },
    {
      'icon': Icons.pin_drop_outlined,
      'title': 'Alamat Pengiriman',
    },
    {
      'icon': Icons.person_search_outlined,
      'title': 'Daftar Teman',
    },
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFFF8C20A), // Warna status bar
      statusBarIconBrightness: Brightness.light, // Warna ikon status bar
    ));

    double currentSize =
        0.12; // Track the current size of the DraggableScrollableSheet
    const double maxChildSize = 0.6;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF8C20A),
        appBar: AppBar(
          toolbarHeight: kToolbarHeight + 10,
          elevation: 0,
          backgroundColor: Color(0xFFF8C20A),
          flexibleSpace: HeaderApp(),
        ),
        body: Stack(
          children: [
            ListView(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30))),
                  child: Column(
                    children: [
                      switchPayuung(),
                      produkKeuanganWidget(),
                      kategoriPilihanWidget(),
                      exploreWellnessWidget(),
                    ],
                  ),
                ),
              ],
            ),
            if (!fullExtend)
              const Opacity(
                opacity: 0.6,
                child: ModalBarrier(dismissible: false, color: Colors.black),
              ),
            NotificationListener<DraggableScrollableNotification>(
              onNotification: (notification) {
                fullExtended(currentSize, notification.extent);
                return true;
              },
              child: DraggableScrollableSheet(
                expand: true,
                initialChildSize:
                    currentSize, // Initial size when it's closed (10% of screen height)
                minChildSize: currentSize, // Minimum size (when minimized)
                maxChildSize:
                    maxChildSize, // Maximum size (when fully expanded)
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: Column(
                      children: [
                        AnimatedSize(
                          duration: const Duration(milliseconds: 200),
                          child: RotatedBox(
                            quarterTurns: fullExtend ? 3 : 1,
                            child: Center(
                              child: Icon(Icons.arrow_forward_ios_rounded),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GridView.builder(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            controller: scrollController,
                            itemCount: navBar.length,
                            itemBuilder: (context, index) {
                              final data = navBar[index];
                              return Column(
                                children: [
                                  Icon(
                                    data['icon'] as IconData,
                                    color: Color(0xFFF8C20A),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    data['title'].toString(),
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding exploreWellnessWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Explore Wellness',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Text('Terpopuler'),
                    SizedBox(width: 5),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(Icons.arrow_drop_down),
                    )
                  ],
                ),
              ),
            ],
          ),
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: exploreWellness.length,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
            itemBuilder: (context, index) {
              final data = exploreWellness[index];
              return Container(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(data['icon'].toString()),
                    Expanded(
                      child: Text(
                        data['title'].toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                    )
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Padding kategoriPilihanWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Kategori Pilihan',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Text('Wishlist'),
                    SizedBox(width: 5),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          color: Color(0xFFF8C20A),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text('0'),
                    )
                  ],
                ),
              ),
            ],
          ),
          GridView.builder(
            itemCount: kategoriPilihan.length,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, mainAxisSpacing: 10, crossAxisSpacing: 10),
            itemBuilder: (context, index) {
              final data = kategoriPilihan[index];
              return Container(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(data['icon'] as IconData),
                    Expanded(
                      child: Text(
                        data['title'].toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                    )
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Padding produkKeuanganWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Produk Keuangan',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          GridView.builder(
            itemCount: produkKeuangan.length,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, mainAxisSpacing: 10, crossAxisSpacing: 10),
            itemBuilder: (context, index) {
              final data = produkKeuangan[index];
              return Container(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(data['icon'] as IconData),
                    Expanded(
                      child: Text(
                        data['title'].toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                    )
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Padding switchPayuung() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        height: 44,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(25)),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    switchPayuungIsPribadi(true);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: isPayungPribadi
                            ? Color(0xFFF8C20A)
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(25)),
                    child: Center(
                        child: Text(
                      'Payuung Pribadi',
                      style: TextStyle(
                          color: isPayungPribadi ? Colors.white : Colors.grey),
                    )),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    switchPayuungIsPribadi(false);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: isPayungPribadi
                            ? Colors.grey.shade200
                            : Color(0xFFF8C20A),
                        borderRadius: BorderRadius.circular(25)),
                    child: Center(
                      child: Text(
                        'Payuung Karyawan',
                        style: TextStyle(
                            color:
                                isPayungPribadi ? Colors.grey : Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderApp extends StatelessWidget {
  const HeaderApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      color: Color(0xFFF8C20A),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selamat Siang',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                'Syahbani',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Spacer(),
          Badge(
            child: Icon(
              Icons.notifications_outlined,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 20),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ));
            },
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              // child: Icon(Icons.person, color: Colors.white),
              child: Text(
                getInitials('Syahbani'),
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}

String getInitials(String value) => value.isNotEmpty
    ? value.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join()
    : '';
