import 'package:flutter/material.dart';
import 'package:my_app/LATIHAN/UTS/form_customer_service_screen.dart';
import 'package:my_app/endpoints/endpoints.dart';
import 'package:my_app/services/data_service.dart';
import 'package:my_app/FrontEnd/elements/components/bottom_up_transition.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_app/dto/dto_uts.dart';
import 'package:my_app/main.dart';


class UtsScreen extends StatefulWidget {
  const UtsScreen({Key? key}) : super(key: key);

  @override
  _UtsScreenState createState() => _UtsScreenState();
}

class _UtsScreenState extends State<UtsScreen> {
  // Future<List<Datas>>? _datas; //Datas diubah menjadi CustomerService
  Future<List<CustomerService>>? _datas; 

  @override
  void initState() {
    super.initState();
    // _datas = DataService.fetchDatas(); //DatasService diubah menjadi CsService
    _datas = DataService.fetchAllCustomerService(); //DatasService diubah 
    DataService.fetchAllCustomerService().then((List<CustomerService> customerServices) {
    print(customerServices);});
  }
  

  Future<void> _confirmAndDelete(CustomerService datas) async {
    // Tampilkan dialog konfirmasi
    final bool confirmed = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Data'),
        content: Text('Are you sure you want to delete this data?'),
        actions: [
          TextButton(
            onPressed: () {
              // Tidak jadi menghapus, kembali dengan nilai false
              Navigator.of(context).pop(false);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Konfirmasi untuk menghapus, kembali dengan nilai true
              Navigator.of(context).pop(true);
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );

    // Jika pengguna mengonfirmasi penghapusan, lanjutkan penghapusan
    if (confirmed) {
      try {
        // Memanggil metode deleteDatas untuk menghapus data dengan ID tertentu
        await DataService.deleteCustomerService(datas.idCustomerService);
        // Refresh data setelah berhasil menghapus
        setState(() {
          _datas = DataService.fetchAllCustomerService(); //DataService ubah menjadi CsService
        });
        // Tampilkan snackbar atau pesan berhasil dihapus
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
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
        title: const Text('Data List'),
        backgroundColor: primary,
        leading: IconButton(
          icon: const Icon(Icons
              .arrow_back), // Customize icon (optional)// Customize color (optional)
          onPressed: () {
            // Your custom back button functionality here
            Navigator.pushReplacementNamed(
                context, '/'); // Default back button behavior
            // You can add additional actions here (e.g., show confirmation dialog)
          },
        ),
      ),
      body: FutureBuilder<List<CustomerService>>(//ganti datas sesuai dto
        future: _datas,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
          
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return Card(
                  elevation: 2,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  child: Image.network(
                                    '${Endpoints.baseURLLive}/public/${item.imageUrl!}',
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            width: 100,
                            height: 100,
                            child: Image.network(
                              '${Endpoints.baseURLLive}/public/${item.imageUrl!}',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name: ${item.titleIssues}',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Description: ${item.descriptionIssues}', // Updated to use description
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 8),
                              
                              RatingBar.builder(
                                initialRating:item.rating?.toDouble() ?? 0.0, // Gunakan 0.0 sebagai nilai default
                                minRating: 0,
                                maxRating: 5,
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                itemCount: 5,
                                itemSize: 20,
                                ignoreGestures: true,
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  // Perbarui rating ketika nilainya berubah
                                  // setState(() {
                                  //   // item.rating = rating;
                                  // });
                                },
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FormScreen(item: item),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _confirmAndDelete(item);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary,
        tooltip: 'Increment',
        onPressed: () {
          // Navigator.pushNamed(context, '/form-screen');
          // BottomUpRoute(page: const FormScreen());
          Navigator.push(context, BottomUpRoute(page: FormScreen()));
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}