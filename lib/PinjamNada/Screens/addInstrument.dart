import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:my_app/navi.dart';
import 'package:my_app/PinjamNada/cubit/user/user_cubit.dart';
import 'package:my_app/PinjamNada/endpoints/endpoints.dart';

class AddInstrument extends StatefulWidget {
  const AddInstrument({Key? key}) : super(key: key);

  @override
  State<AddInstrument> createState() => _AddInstrumentState();
}

class _AddInstrumentState extends State<AddInstrument> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  File? _image;
  int? _instrumentTypeId;

  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  late UserCubit _userCubit;

  @override
  void initState() {
    super.initState();
    _userCubit = BlocProvider.of<UserCubit>(context);
  }

  Future<void> _addPhoto() async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Pilih dari galeri'),
                onTap: () async {
                  Navigator.pop(context);
                  final pickedFile =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      _image = File(pickedFile.path);
                    });
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Ambil foto'),
                onTap: () async {
                  Navigator.pop(context);
                  final pickedFile =
                      await picker.pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    setState(() {
                      _image = File(pickedFile.path);
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _postDataWithImage(BuildContext context) async {
    if (_image == null) {
      // Handle case where no image is selected
      return;
    }

    int userID = _userCubit.userID;
    var url = '${Endpoints.pinjamNadaInstruments}/add_instrument/$userID';
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );
    request.fields['instrument_name'] = _titleController.text;
    request.fields['description'] = _descriptionController.text;
    request.fields['location'] = _locationController.text;
    request.fields['instrument_type_id'] = _instrumentTypeId.toString();

    var multipartFile = await http.MultipartFile.fromPath(
      'image',
      _image!.path,
    );
    request.files.add(multipartFile);

    var response = await request.send();
    if (response.statusCode == 201) {
      debugPrint('Data and image posted successfully!');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    } else {
      debugPrint('Error posting data: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text('Add Instrument', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF5C88C4),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _addPhoto,
                child: Container(
                  width: double.infinity,
                  height: 200.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: _image == null
                      ? const Icon(
                          Icons.add_a_photo,
                          size: 50.0,
                          color: Colors.grey,
                        )
                      : Image.file(
                          _image!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Nama Instrument',
                        hintText: 'Masukkan nama instrument',
                        labelStyle: TextStyle(color: Color(0xFF5C88C4)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF5C88C4)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama instrument tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: null,
                      decoration: const InputDecoration(
                        labelText: 'Deskripsi Instrument',
                        hintText: 'Jelaskan instrument Anda secara detail',
                        labelStyle: TextStyle(color: Color(0xFF5C88C4)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF5C88C4)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Deskripsi instrument tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: _locationController,
                      decoration: const InputDecoration(
                        labelText: 'Lokasi',
                        hintText: 'Masukkan lokasi instrument',
                        labelStyle: TextStyle(color: Color(0xFF5C88C4)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF5C88C4)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Lokasi tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField<int>(
                      value: _instrumentTypeId,
                      onChanged: (value) {
                        setState(() {
                          _instrumentTypeId = value;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Jenis Instrument',
                        labelStyle: TextStyle(color: Color(0xFF5C88C4)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF5C88C4)),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem<int>(
                          value: 1,
                          child: Text('String'),
                        ),
                        DropdownMenuItem<int>(
                          value: 2,
                          child: Text('Wind'),
                        ),
                        DropdownMenuItem<int>(
                          value: 3,
                          child: Text('Percussion'),
                        ),
                        DropdownMenuItem<int>(
                          value: 4,
                          child: Text('Keyboard'),
                        ),
                        DropdownMenuItem<int>(
                          value: 5,
                          child: Text('Electronic'),
                        ),
                      ],
                      validator: (value) {
                        if (value == null) {
                          return 'Pilih jenis instrument';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _postDataWithImage(context);
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.blueAccent; // Warna saat tombol ditekan
                    }
                    return const Color(0xFF5C88C4); // Warna default
                  }),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                  ),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                child: const Text(
                  'Simpan',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
