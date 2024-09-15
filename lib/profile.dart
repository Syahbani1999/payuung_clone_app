// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:payuung_clone_app/widgets/dropdown_widget.dart';
import 'package:payuung_clone_app/widgets/forms_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int currentStep = 0;
  ImagePicker picker = ImagePicker();
  String userImage = '';
  String imagePath = '';
  String fileName = '';
  File? image;

  Future imagePick(
    ImageSource source,
  ) async {
    try {
      final _image = await picker.pickImage(source: source);
      if (_image == null) return;
      var imageTemp = File(_image.path);

      image = imageTemp;
      imagePath = image!.path;
      fileName = imageTemp.path.split('/').last;
    } on PlatformException catch (e) {
      print('error pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey.shade700),
        elevation: 0,
        title: Text(
          'Informasi Pribadi',
          style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
        ),
        centerTitle: true,
        leading: Icon(Icons.arrow_back_ios_new_rounded),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          children: [
            Expanded(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFF8C20A)),
                    onPressed: currentStep > 0 ? _goToPreviousStep : null,
                    child: Text('Sebelumnya'))),
            SizedBox(width: 10),
            Expanded(
                child: ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Color(0xFFF8C20A)),
              onPressed: currentStep < 2
                  ? _goToNextStep
                  : currentStep == 2
                      ? () {
                          Navigator.of(context).pop();
                        }
                      : null,
              child: Text(currentStep == 2 ? 'Kirim' : 'Selanjutnya'),
            ))
          ],
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customStep(
                stepNumber: 1,
                isActive: currentStep >= 0,
                title: 'Biodata Diri',
              ),
              customStep(
                stepNumber: 2,
                isActive: currentStep >= 1,
                title: 'Alamat Pribadi',
              ),
              customStep(
                stepNumber: 3,
                isActive: currentStep >= 2,
                title: 'Informasi Perusahaan',
              ),
            ],
          ),
          SizedBox(height: 30), // Add space between stepper and content
          Expanded(
            child: Container(
              child: stepContent(currentStep),
            ),
          ),
        ],
      ),
    );
  }

  Widget customStep({
    required int stepNumber,
    required bool isActive,
    required String title,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          // Step indicator (Circle)
          CircleAvatar(
            radius: 20.0,
            backgroundColor: isActive ? Color(0xFFF8C20A) : Colors.grey,
            child: Text(
              stepNumber.toString(),
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 8.0),
          SizedBox(
            width: 90,
            child: Text(
              title,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isActive ? Color(0xFFF8C20A) : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Method to display content based on the step
  Widget stepContent(int step) {
    switch (step) {
      case 0:
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          shrinkWrap: true,
          children: [
            CustomFormField(
              padding: EdgeInsets.symmetric(vertical: 5),
              title: '* NAMA LENGKAP',
              borderColor: Colors.grey,
            ),
            CustomFormField(
              padding: EdgeInsets.symmetric(vertical: 5),
              readOnly: true,
              title: '* TANGGAL LAHIR',
              borderColor: Colors.grey,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                Text(
                  '* JENIS KELAMIN',
                ),
                SizedBox(height: 5),
                ReuseableDropdown<String>(
                  lists: ['LAKI-LAKI', 'PEREMPUAN'].map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (value) {},
                ),
                SizedBox(height: 5),
              ],
            ),
            CustomFormField(
              padding: EdgeInsets.symmetric(vertical: 5),
              title: '* ALAMAT EMAIL',
              borderColor: Colors.grey,
            ),
            CustomFormField(
              padding: EdgeInsets.symmetric(vertical: 5),
              title: '* NO HP',
              borderColor: Colors.grey,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                Text(
                  'PENDIDIKAN',
                ),
                SizedBox(height: 5),
                ReuseableDropdown<String>(
                  lists: [
                    'SD',
                    'SMP',
                    'SMA',
                    'D1',
                    'D2',
                    'D3',
                    'S1',
                    'S2',
                    'S3'
                  ].map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (value) {},
                ),
                SizedBox(height: 5),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                Text(
                  'STATUS PERNIKAHAN',
                ),
                SizedBox(height: 5),
                ReuseableDropdown<String>(
                  lists: ['Belum Kawin', 'Kawin', 'Janda', 'Duda']
                      .map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (value) {},
                ),
                SizedBox(height: 5),
              ],
            ),
          ],
        );
      case 1:
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          shrinkWrap: true,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade200,
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      showImageSource(context);
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          child: Icon(Icons.chrome_reader_mode_rounded),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Upload KTP',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  CustomFormField(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    title: '* NIK',
                    borderColor: Colors.grey,
                  ),
                ],
              ),
            ),
            CustomFormField(
              padding: EdgeInsets.symmetric(vertical: 5),
              title: '* ALAMAT SESUAI KTP',
              borderColor: Colors.grey,
            ),
            CustomFormField(
              padding: EdgeInsets.symmetric(vertical: 5),
              title: '* PROVINSI',
              borderColor: Colors.grey,
            ),
            CustomFormField(
              padding: EdgeInsets.symmetric(vertical: 5),
              title: '* KOTA/KABUPATEN',
              borderColor: Colors.grey,
            ),
            CustomFormField(
              padding: EdgeInsets.symmetric(vertical: 5),
              title: '* KECAMATAN',
              borderColor: Colors.grey,
            ),
            CustomFormField(
              padding: EdgeInsets.symmetric(vertical: 5),
              title: '* KELURAHAN',
              borderColor: Colors.grey,
            ),
            CustomFormField(
              padding: EdgeInsets.symmetric(vertical: 5),
              title: '* KODE POS',
              borderColor: Colors.grey,
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              activeColor: Color(0xFFF8C20A),
              controlAffinity: ListTileControlAffinity.leading,
              value: true,
              onChanged: (value) {},
              title: Text(
                'Alamat domisili sama dengan alamat KTP',
              ),
            ),
          ],
        );
      case 2:
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          shrinkWrap: true,
          children: [
            CustomFormField(
              padding: EdgeInsets.symmetric(vertical: 5),
              title: '* NAMA USAHA / PERUSAHAAN',
              borderColor: Colors.grey,
            ),
            CustomFormField(
              padding: EdgeInsets.symmetric(vertical: 5),
              title: '* ALAMAT USAHA / PERUSAHAAN',
              borderColor: Colors.grey,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                Text(
                  'JABATAN',
                ),
                SizedBox(height: 5),
                ReuseableDropdown<String>(
                  lists: [
                    'Non-Staff',
                    'Staff',
                    'Supervisor',
                    'Manajer',
                    'Direktur',
                    'Lainnya'
                  ].map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (value) {},
                ),
                SizedBox(height: 5),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                Text(
                  'LAMA BEKERJA',
                ),
                SizedBox(height: 5),
                ReuseableDropdown<String>(
                  lists: [
                    '<6 Bulan',
                    '6 Bulan - 1 Tahun',
                    '1 - 2 Tahun',
                    '> 2 Tahun'
                  ].map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (value) {},
                ),
                SizedBox(height: 5),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                Text(
                  'SUMBER PENDAPATAN',
                ),
                SizedBox(height: 5),
                ReuseableDropdown<String>(
                  lists: [
                    'Gaji',
                    'Keuntungan Bisnis',
                    'Bunga Tabungan',
                    'Warisan',
                    'Dana dari orang tua atau anak',
                    'Undian',
                    'Keuntungan Inventasi',
                    'Lainnya'
                  ].map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (value) {},
                ),
                SizedBox(height: 5),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                Text(
                  'PENDAPATAN KOTOR',
                ),
                SizedBox(height: 5),
                ReuseableDropdown<String>(
                  lists: [
                    '< 10 Juta',
                    '10 - 50 Juta',
                    '50 - 100 Juta',
                    '100 - 500 Juta',
                    '500 Juta - 1 Milyar',
                    '> 1 Milyar'
                  ].map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (value) {},
                ),
                SizedBox(height: 5),
              ],
            ),
            CustomFormField(
              padding: EdgeInsets.symmetric(vertical: 5),
              title: 'NAMA BANK',
              borderColor: Colors.grey,
            ),
            CustomFormField(
              padding: EdgeInsets.symmetric(vertical: 5),
              title: 'CABANG BANK',
              borderColor: Colors.grey,
            ),
            CustomFormField(
              padding: EdgeInsets.symmetric(vertical: 5),
              title: 'NOMOR REKENING',
              borderColor: Colors.grey,
            ),
            CustomFormField(
              padding: EdgeInsets.symmetric(vertical: 5),
              title: 'NAMA PEMILIK REKENING',
              borderColor: Colors.grey,
            ),
          ],
        );
      default:
        return Text('Invalid step');
    }
  }

  // Function to move to the next step
  void _goToNextStep() {
    setState(() {
      if (currentStep < 2) currentStep++;
    });
  }

  // Function to move to the previous step
  void _goToPreviousStep() {
    setState(() {
      if (currentStep > 0) currentStep--;
    });
  }

  Future<ImageSource?> showImageSource(BuildContext context) async {
    return showModalBottomSheet(
        context: context,
        builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt_rounded),
                  title: const Text('Camera'),
                  onTap: () {
                    imagePick(ImageSource.camera);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.image),
                  title: const Text('Gallery'),
                  onTap: () {
                    imagePick(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                )
              ],
            ));
  }
}
