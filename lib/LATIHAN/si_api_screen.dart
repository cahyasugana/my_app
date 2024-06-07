// // ignore_for_file: library_private_types_in_public_api

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:my_app/FrontEnd/elements/components/bottom_up_transition.dart';
// import 'package:my_app/LATIHAN/form_screen.dart';
// import 'package:my_app/dto/news.dart';
// import 'package:my_app/endpoints/endpoints.dart';
// import 'package:my_app/services/data_service.dart';

// class DatasScreen extends StatefulWidget {
//   const DatasScreen({Key? key}) : super(key: key);

//   @override
//   _DatasScreenState createState() => _DatasScreenState();
// }

// class _DatasScreenState extends State<DatasScreen> {
//   Future<List<Datas>>? _datas;

//   @override
//   void initState() {
//     super.initState();
//     _datas = DataService.fetchDatas();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Data List'),
//         leading: IconButton(
//           icon: const Icon(Icons
//               .arrow_back), // Customize icon (optional)// Customize color (optional)
//           onPressed: () {
//             // Your custom back button functionality here
//             Navigator.pushReplacementNamed(
//                 context, '/'); // Default back button behavior
//             // You can add additional actions here (e.g., show confirmation dialog)
//           },
//         ),
//       ),
//       body: FutureBuilder<List<Datas>>(
//         future: _datas,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             final data = snapshot.data!;
//             return ListView.builder(
//               itemCount: data.length,
//               itemBuilder: (context, index) {
//                 final item = data[index];
//                 return ListTile(
//                   title: item.imageUrl != null
//                       ? Row(
//                           children: [
//                             Image.network(
//                               fit: BoxFit.fitWidth,
//                               width: 350,
//                               Uri.parse(
//                                       '${Endpoints.baseURLLive}/public/${item.imageUrl!}')
//                                   .toString(),
//                               errorBuilder: (context, error, stackTrace) =>
//                                   const Icon(Icons
//                                       .error), // Display error icon if image fails to load
//                             ),
//                           ],
//                         )
//                       : null,
//                   subtitle: Column(children: [
//                     Text('Name : ${item.name}',
//                         style: GoogleFonts.poppins(
//                           fontSize: 14,
//                           color: const Color.fromARGB(255, 36, 31, 31),
//                           fontWeight: FontWeight.normal,
//                         )),
//                     const Divider()
//                   ]),
//                 );
//               },
//             );
//           } else if (snapshot.hasError) {
//             return Center(child: Text('${snapshot.error}'));
//           }
//           return const Center(child: CircularProgressIndicator());
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: const Color.fromARGB(255, 54, 40, 176),
//         tooltip: 'Increment',
//         onPressed: () {
//           // Navigator.pushNamed(context, '/form-screen');
//           // BottomUpRoute(page: const FormScreen());
//           Navigator.push(context, BottomUpRoute(page: const FormScreen()));
//         },
//         child: const Icon(Icons.add, color: Colors.white, size: 28),
//       ),
//     );
//   }
// }

//MEW SCREEN

import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/FrontEnd/elements/components/bottom_up_transition.dart';
import 'package:my_app/LATIHAN/form_screen.dart';
import 'package:my_app/dto/news.dart';
import 'package:my_app/endpoints/endpoints.dart';
import 'package:my_app/main.dart';
import 'package:my_app/services/data_service.dart';
// import 'package:my_app/FrontEnd/elements/components/text_container.dart';

class DatasScreen extends StatefulWidget {
  const DatasScreen({Key? key}) : super(key: key);

  @override
  _DatasScreenState createState() => _DatasScreenState();
}

class _DatasScreenState extends State<DatasScreen> {
  Future<List<Datas>>? _datas;

  final TextEditingController _idController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _datas = DataService.fetchDatas();
  }

  Future<void> _confirmAndDelete(Datas datas) async {
    // Tampilkan dialog konfirmasi
    final bool confirmed = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Data'),
        content: const Text('Are you sure you want to delete this data?'),
        actions: [
          TextButton(
            onPressed: () {
              // Tidak jadi menghapus, kembali dengan nilai false
              Navigator.of(context).pop(false);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Konfirmasi untuk menghapus, kembali dengan nilai true
              Navigator.of(context).pop(true);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    // Jika pengguna mengonfirmasi penghapusan, lanjutkan penghapusan
    if (confirmed) {
      try {
        // Memanggil metode deleteDatas untuk menghapus data dengan ID tertentu
        await DataService.deleteDatas(datas.idDatas);
        // Refresh data setelah berhasil menghapus
        setState(() {
          _datas = DataService.fetchDatas();
        });
        // Tampilkan snackbar atau pesan berhasil dihapus
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Data deleted successfully'),
          ),
        );
      } catch (e) {
        // Tangani kesalahan jika gagal menghapus data
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete data: $e'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        centerTitle: true,
        title: const Text(
          'Latihan API Gambar',
          style: TextStyle(
            color: bases, // Set text color to white
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _idController,
                    decoration: const InputDecoration(
                      labelText: 'Enter Datas ID',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    // Navigator.pushNamed(context, '/form-screen');
                    // BottomUpRoute(page: const FormScreen());
                    Navigator.push(
                        context, BottomUpRoute(page: const FormScreen()));
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: FutureBuilder<List<Datas>>(
                future: _datas,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No data available'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final datas = snapshot.data![index];
                        final bgColor = index % 2 == 0
                            ? Colors.grey[
                                200] // Warna latar belakang untuk indeks genap
                            : Colors
                                .white; // Warna latar belakang untuk indeks ganjil
                        return Container(
                          color: bgColor,
                          child: ListTile(
                            leading: datas.imageUrl != null
                                ? GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                            child: Image.network(
                                              '${Endpoints.baseURLLive}/public/${datas.imageUrl!}',
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: 100, // Set a fixed width
                                      height: 100, // Set a fixed height
                                      child: Image.network(
                                        '${Endpoints.baseURLLive}/public/${datas.imageUrl!}',
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Icon(Icons.error),
                                      ),
                                    ),
                                  )
                                : null,
                            title: Text(
                              '${datas.name} | ${datas.idDatas}',
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Created At: ${datas.createdAt}'),
                                Text('Updated At: ${datas.updatedAt}'),
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                _confirmAndDelete(datas);
                              },
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
