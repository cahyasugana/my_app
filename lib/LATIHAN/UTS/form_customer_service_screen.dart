// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:my_app/endpoints/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/dto/dto_uts.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_app/LATIHAN/UTS/customer_service_screen.dart';
import 'package:my_app/main.dart';

class FormScreen extends StatefulWidget {
  final CustomerService? item;

  FormScreen({this.item, Key? key}) : super(key: key);

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  String _selectedDivision = 'Dailing'; // Default division
  double _priority = 0; // Default priority

  void initState() {
    super.initState();
    dRating = widget.item?.rating ?? 0;
    if (widget.item != null) {
      print('Item: ${widget.item?.idCustomerService}');
      _titleController.text = widget.item?.titleIssues ?? '';
      //tambah deskripsi, dll
      _deskripsiController.text = widget.item?.descriptionIssues ?? '';
    } else {
      print('Item is null');
    }
  }

  final _titleController = TextEditingController();
  String _title = "";
  final _deskripsiController = TextEditingController();
  String _deskripsi = "";
  //tambah  lainnya jika ada
  int dRating = 0;
  File? galleryFile;
  final picker = ImagePicker();

  _showPicker({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future getImage(
    ImageSource img,
  ) async {
    final pickedFile = await picker.pickImage(source: img);
    XFile? xfilePick = pickedFile;
    setState(
      () {
        if (xfilePick != null) {
          galleryFile = File(pickedFile!.path);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }

  @override
  void dispose() {
    _titleController.dispose(); // Dispose of controller when widget is removed
    super.dispose();
  }

  saveData() {
    debugPrint(_title);
  }

  Future<void> _postDataWithImage(BuildContext context) async {
    if (galleryFile == null) {
      // return;
      // Handle case where no image is selected
    }

    var request =
        MultipartRequest('POST', Uri.parse(Endpoints.customerServiceWithNIM));
    request.fields['title_issues'] =
        _titleController.text; // Add other data fields
//tambah deskripsi
    request.fields['description_issues'] = _deskripsiController.text;
//tambahrating

    request.fields['rating'] = dRating.toString();

    var multipartFile = await MultipartFile.fromPath(
      'image',
      galleryFile!.path,
    );
    request.files.add(multipartFile);

    print(_titleController.text);
    print(_deskripsiController.text);
    print(dRating);

    request.send().then((response) {
      // Handle response (success or error)
      if (response.statusCode == 201) {
        debugPrint('Data and image posted successfully!');
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const UtsScreen()));
        // Navigator.pushReplacementNamed(context, '/datas-screen');
      } else {
        debugPrint('Error posting data: ${response.statusCode}');
      }
    });
  }

  Future<void> _editData(BuildContext context) async {
    var request = MultipartRequest(
        'POST',
        Uri.parse(
            '${Endpoints.customerServiceWithNIM}/${widget.item?.idCustomerService}'));

    if (galleryFile != null) {
      var multipartFile = await MultipartFile.fromPath(
        'image',
        galleryFile!.path,
      ); // Handle case where no image is selected
      request.files.add(multipartFile);
    }

    request.fields['title_issues'] =
        _titleController.text; // Add other data fields
    //tambah deskripsi
    request.fields['description_issues'] = _deskripsiController.text;
    //tambahrating

    request.fields['rating'] = dRating.toString();

    print(_titleController.text);
    print(_deskripsiController.text);
    print(widget.item?.rating);
    request.send().then((response) {
      // Handle response (success or error)
      if (response.statusCode == 200) {
        // Data updated successfully
        print("success");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const UtsScreen()));
      } else {
        // Handle error
        print('Failed to update data: ${response.statusCode}');
      }
    }).catchError((error) {
      // Handle other errors
      print('Error updating data: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        title: null,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white), // recolor the icon
      ),
      // ignore: sized_box_for_whitespace
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (widget.item == null ? 'Create datas' : 'Edit datas'),
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    "Fill the datas below, make sure you add titles and upload the images",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromRGBO(225, 95, 27, .3),
                                  blurRadius: 20,
                                  offset: Offset(0, 10))
                            ]),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _showPicker(context: context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade200))),
                                width: double.infinity, // Fill available space
                                height: 150, // Adjust height as needed
                                // color: Colors.grey[200], // Placeholder color
                                child: galleryFile == null
                                    ? Center(
                                        child: Text('Pick your Image here',
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              color: const Color.fromARGB(
                                                  255, 124, 122, 122),
                                              fontWeight: FontWeight.w500,
                                            )))
                                    : Center(
                                        child: Image.file(galleryFile!),
                                      ), // Placeholder text
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade200))),
                              child: TextField(
                                controller: _titleController,
                                decoration: InputDecoration(
                                    hintText: "Title Issues",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                                onChanged: (value) {
                                  // Update state on text change
                                  setState(() {
                                    _title =
                                        value; // Update the _title state variable
                                  });
                                },
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade200))),
                              child: TextField(
                                controller: _deskripsiController,
                                decoration: const InputDecoration(
                                    hintText: "Deskripsi Issues",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                                onChanged: (value) {
                                  // Update state on text change
                                  setState(() {
                                    _deskripsi =
                                        value; // Update the _title state variable
                                  });
                                },
                              ),
                            ),
                            DropdownButtonFormField<String>(
                              value: _selectedDivision,
                              decoration: InputDecoration(
                                labelText: 'Division',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedDivision = newValue!;
                                });
                              },
                              items: <String>[
                                'Dailing',
                                'Teknis',
                                'Support'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 20),
                            Slider(
                              value: _priority,
                              onChanged: (newValue) {
                                setState(() {
                                  _priority = newValue;
                                });
                              },
                              min: 0,
                              max: 10, // Set the maximum priority value
                              divisions:
                                  10, // Divide the slider into 10 divisions
                              label: _priority.toString(),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade200))),
                              child: RatingBar.builder(
                                initialRating: widget.item?.rating
                                        ?.toDouble() ??
                                    0.0, // Gunakan 0.0 sebagai nilai default
                                minRating: 0,
                                maxRating: 5,
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                itemCount: 5,
                                itemSize: 20,
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  // Perbarui rating ketika nilainya berubah
                                  setState(() {
                                    dRating = rating.toInt();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary,
        tooltip: 'Increment',
        onPressed: () {
          widget.item?.idCustomerService == null
              ? _postDataWithImage(context)
              : _editData(context);
        },
        child: const Icon(Icons.save, color: Colors.white, size: 28),
      ),
    );
  }
}
