import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/PinjamNada/cubit/instruments/instruments_cubit.dart';
import 'package:my_app/PinjamNada/cubit/user/user_cubit.dart';
import 'package:my_app/PinjamNada/endpoints/endpoints.dart';
import 'package:my_app/PinjamNada/Screens/instrumentDetail.dart'; // import UserCubit
import 'package:my_app/PinjamNada/services/data_service.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late UserCubit _userCubit;
  late DataService _dataService;

  @override
  void initState() {
    super.initState();
    _dataService = DataService();
    // Initialize _userCubit from context
    _userCubit = BlocProvider.of<UserCubit>(context);

    // _myLoans = _dataService.fetchMyLoans(_userCubit.userID);

    // Ensure data is fetched when the screen is initialized
    context
        .read<InstrumentsCubit>()
        .fetchExcludingUser(userId: _userCubit.state.userID);
  }

  Future<void> _refreshData() async {
    // Trigger the fetch function in the InstrumentsCubit to refresh data
    await context
        .read<InstrumentsCubit>()
        .fetchExcludingUser(userId: _userCubit.state.userID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<InstrumentsCubit, InstrumentsState>(
        builder: (context, state) {
          if (state.instruments == null) {
            // Return a loading indicator or an empty widget
            return const Center(child: Text('No Data Available (null)'));
          } else if (state.instruments!.isEmpty) {
            // Return a loading indicator or an empty widget
            return const Center(child: Text('No Data Available'));
          } else {
            return RefreshIndicator(
              onRefresh: _refreshData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          DropdownButton<String>(
                            icon: const Icon(Icons.arrow_drop_down),
                            items: <String>[
                              'Filter 1',
                              'Filter 2',
                              'Filter 3',
                              'Filter 4'
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {},
                            hint: const Text('Filter'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.instruments!.length,
                      itemBuilder: (context, index) {
                        var instrument = state.instruments![index];
                        return GestureDetector(
                          onTap: () {
                            // Navigasi ke halaman detail, misalnya menggunakan Navigator
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InstrumentDetail(
                                    instrument: instrument, status: 4),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      instrument.instrumentName,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: FadeInImage.assetNetwork(
                                            placeholder:
                                                'assets/images/placeholder.png',
                                            image:
                                                '${Endpoints.staticImage}/${instrument.image}',
                                            fit: BoxFit.cover,
                                            width: 100,
                                            height: 100,
                                            imageErrorBuilder:
                                                (context, error, stackTrace) {
                                              return Image.asset(
                                                'assets/images/placeholder.png',
                                                fit: BoxFit.cover,
                                                width: 100,
                                                height: 100,
                                              );
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Pemilik: ${instrument.ownerUsername}',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                'Lokasi: ${instrument.location}',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                'Deskripsi: ${instrument.description}',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
