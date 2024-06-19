import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:my_app/PinjamNada/Screens/myInstrument.dart';
import 'package:my_app/PinjamNada/cubit/my_instruments/my_instruments_cubit.dart';
import 'package:my_app/navi.dart';
import 'package:my_app/PinjamNada/cubit/user/user_cubit.dart';
import 'package:my_app/PinjamNada/dto/Instrument.dart';
import 'package:my_app/PinjamNada/dto/loanRequest.dart';
import 'package:my_app/PinjamNada/endpoints/endpoints.dart';
import 'package:my_app/PinjamNada/services/data_service.dart';

class InstrumentDetail extends StatefulWidget {
  final Instruments instrument;
  final int status;

  const InstrumentDetail(
      {Key? key, required this.instrument, required this.status})
      : super(key: key);

  @override
  State<InstrumentDetail> createState() => _InstrumentDetailState();
}

class _InstrumentDetailState extends State<InstrumentDetail> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  File? _image;
  int? _instrumentTypeId;

  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  late UserCubit _userCubit;
  late Future<List<RequestLoan>> _futureRequestLoans;
  late MyInstrumentsCubit _myInstrumentsCubit;
  late DataService _dataService;

  @override
  void initState() {
    super.initState();
    _userCubit = BlocProvider.of<UserCubit>(context);
    _initEditMode();
    _dataService = DataService();
    if (widget.status == 2) {
      _futureRequestLoans =
          _dataService.fetchRequestListById(widget.instrument.instrumentId);
      print(_futureRequestLoans);
    }
  }

  void _initEditMode() {
    _titleController.text = widget.instrument.instrumentName;
    _descriptionController.text = widget.instrument.description;
    _locationController.text = widget.instrument.location;
    _instrumentTypeId = widget.instrument.instrumentTypeId;
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

  Future<void> _addLoan(BuildContext context, int borrowed_id) async {
    //hapus request loan
    var url =
        '${Endpoints.deleteRequestLoan}/${widget.instrument.instrumentId}';
    var request = http.MultipartRequest('DELETE', Uri.parse(url));
    var response = await request.send();

    //tambah loan
    url = '${Endpoints.addRequestLoan}/${widget.instrument.instrumentId}';
    request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['borrowed_id'] = borrowed_id.toString();
    var response2 = await request.send();

    url =
        '${Endpoints.pinjamNadaInstruments}/update_instrument/${widget.instrument.instrumentId}';
    request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['availability_status'] = "3";
    var response3 = await request.send();

    if (response.statusCode == 200 &&
        response2.statusCode == 201 &&
        response3.statusCode == 200) {
      print("sukses");
      Navigator.pop(context);
    } else {
      print(borrowed_id.toString());
      print("gagal");
    }
  }

  Future<void> _addRequestLoan(BuildContext context) async {
    var instrumentId = widget.instrument.instrumentId;
    var requesterId = _userCubit.userID;
    var message = _commentController.text;

    // Send add request loan first
    var url = '${Endpoints.addRLoan}/';
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['instrumen_id'] = instrumentId.toString();
    request.fields['requester_id'] = requesterId.toString();
    request.fields['message'] = message.toString();
    var response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("sukses");

      // Update the instrument status
      url =
          '${Endpoints.pinjamNadaInstruments}/update_instrument/$instrumentId';
      request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['availability_status'] = "2";
      var response2 = await request.send();

      if (response2.statusCode == 200 || response2.statusCode == 201) {
        print("instrument status updated");
      } else {
        print("update instrument gagal");
      }

      // Fetch instruments and pop context
      _myInstrumentsCubit = BlocProvider.of<MyInstrumentsCubit>(context);
      _myInstrumentsCubit.fetchInstrumentsByID(userId: _userCubit.state.userID);
      Navigator.pop(context);
    } else {
      print("add request loan gagal");
    }
  }

  Future<void> _resetInstrument(BuildContext context) async {
    var url =
        '${Endpoints.pinjamNadaInstruments}/update_instrument/${widget.instrument.instrumentId}';
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['availability_status'] = "1";
    var response = await request.send();

    //hapus request loan
    url = '${Endpoints.deleteLoan}/${widget.instrument.instrumentId}';
    request = http.MultipartRequest('DELETE', Uri.parse(url));
    var response2 = await request.send();

    if (response.statusCode == 200) {
      print("sukses");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    } else {
      print("gagal");
    }
  }

  Future<void> _updateInstrument(BuildContext context) async {
    var url =
        '${Endpoints.pinjamNadaInstruments}/update_instrument/${widget.instrument.instrumentId}';
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['instrument_name'] = _titleController.text;
    request.fields['description'] = _descriptionController.text;
    request.fields['location'] = _locationController.text;
    request.fields['instrument_type_id'] = _instrumentTypeId.toString();

    if (_image != null) {
      var multipartFile = await http.MultipartFile.fromPath(
        'image',
        _image!.path,
      );
      request.files.add(multipartFile);
    }

    var response = await request.send();
    if (response.statusCode == 200) {
      debugPrint('Data and image updated successfully!');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    } else {
      debugPrint('Error updating data: ${response.statusCode}');
    }
  }

  Future<void> _deleteInstrument(BuildContext context) async {
    var url =
        '${Endpoints.pinjamNadaInstruments}/delete_instrument/${widget.instrument.instrumentId}';
    var response = await http.delete(Uri.parse(url));
    if (response.statusCode == 200) {
      debugPrint('Instrument deleted successfully!');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    } else {
      debugPrint('Error deleting instrument: ${response.statusCode}');
    }
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Penghapusan'),
          content:
              const Text('Apakah Anda yakin ingin menghapus instrumen ini?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteInstrument(context);
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
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
        title: widget.status == 1
            ? const Text('Edit Instrument',
                style: TextStyle(color: Colors.white))
            : widget.status == 2
                ? const Text('List Peminjam',
                    style: TextStyle(color: Colors.white))
                : widget.status == 3
                    ? const Text('Reset Instrument',
                        style: TextStyle(color: Colors.white))
                    : const Text('Pinjam Instrument',
                        style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF5C88C4),
        actions: [
          widget.status == 1
              ? IconButton(
                  icon: const Icon(Icons.delete, color: Colors.white),
                  onPressed: () => _confirmDelete(context),
                )
              : SizedBox.shrink(),
        ],
      ),
      body: widget.status == 2
          ? Center(
              child: FutureBuilder<List<dynamic>>(
                  future: _futureRequestLoans,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          RequestLoan loan = snapshot.data![index];
                          return ListTile(
                            title: Text(loan.fullName),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Message: ${loan.message.toString()}'),
                                Text('Phone: ${loan.phone.toString()}'),
                                Text(
                                    'Request Date: ${loan.requestDate.toString()}'),
                              ],
                            ),
                            trailing: TextButton(
                              child: Text(
                                'Accept',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                _addLoan(context, loan.userId);
                              },
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Text(
                          'No data available'); // Handle the case where no data is available
                    }
                  }))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: widget.status == 1 ? _addPhoto : () => {},
                      child: Container(
                        width: double.infinity,
                        height: 200.0,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: _image == null
                            ? FadeInImage.assetNetwork(
                                placeholder: 'assets/images/placeholder.png',
                                image:
                                    '${Endpoints.staticImage}/${widget.instrument.image}',
                                fit: BoxFit.cover,
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/placeholder.png',
                                    fit: BoxFit.cover,
                                  );
                                },
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
                            readOnly: widget.status == 1 ? false : true,
                            decoration: const InputDecoration(
                              labelText: 'Nama Instrument',
                              hintText: 'Masukkan nama instrument',
                              labelStyle: TextStyle(color: Color(0xFF5C88C4)),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF5C88C4)),
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
                            readOnly: widget.status == 1 ? false : true,
                            maxLines: null,
                            decoration: const InputDecoration(
                              labelText: 'Deskripsi Instrument',
                              hintText:
                                  'Jelaskan instrument Anda secara detail',
                              labelStyle: TextStyle(color: Color(0xFF5C88C4)),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF5C88C4)),
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
                            readOnly: widget.status == 1 ? false : true,
                            decoration: const InputDecoration(
                              labelText: 'Lokasi',
                              hintText: 'Masukkan lokasi instrument',
                              labelStyle: TextStyle(color: Color(0xFF5C88C4)),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF5C88C4)),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Lokasi tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          widget.status == 1
                              ? DropdownButtonFormField<int>(
                                  value: _instrumentTypeId,
                                  onChanged: (value) {
                                    setState(() {
                                      _instrumentTypeId = value;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Jenis Instrument',
                                    labelStyle:
                                        TextStyle(color: Color(0xFF5C88C4)),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFF5C88C4)),
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
                                )
                              : TextFormField(
                                  readOnly:
                                      true, // Membuat field tidak dapat diedit
                                  decoration: const InputDecoration(
                                    labelText: 'Jenis Instrument',
                                    labelStyle:
                                        TextStyle(color: Color(0xFF5C88C4)),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFF5C88C4)),
                                    ),
                                  ),
                                  controller: TextEditingController(
                                    text: _instrumentTypeId == 1
                                        ? 'String'
                                        : _instrumentTypeId == 2
                                            ? 'Wind'
                                            : _instrumentTypeId == 3
                                                ? 'Percussion'
                                                : _instrumentTypeId == 4
                                                    ? 'Keyboard'
                                                    : _instrumentTypeId == 5
                                                        ? 'Electronic'
                                                        : '',
                                  ),
                                ),
                          widget.status == 4
                              ? TextFormField(
                                  controller: _commentController,
                                  decoration: const InputDecoration(
                                    labelText: 'Pesan',
                                    hintText: 'Masukkan Pesan Peminjaman',
                                    labelStyle:
                                        TextStyle(color: Color(0xFF5C88C4)),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFF5C88C4)),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Pesan tidak boleh kosong';
                                    }
                                    return null;
                                  },
                                )
                              : SizedBox.shrink(),
                          const SizedBox(height: 20.0),
                          widget.status != 2
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        if (widget.status == 1) {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _updateInstrument(context);
                                          }
                                        } else if (widget.status == 3) {
                                          _resetInstrument(context);
                                        } else {
                                          _addRequestLoan(context);
                                        }
                                      },
                                      child: widget.status == 1
                                          ? Text('Simpan Perubahan')
                                          : widget.status == 3
                                              ? Text('Reset Instrument')
                                              : Text('Pinjam Instrument'),
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor:
                                            const Color(0xFF5C88C4),
                                        textStyle:
                                            const TextStyle(fontSize: 16.0),
                                      ),
                                    ),
                                  ],
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
