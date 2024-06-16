import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/PinjamNada/cubit/instruments/instruments_cubit.dart';
import 'package:my_app/PinjamNada/cubit/user/user_cubit.dart';
import 'package:my_app/PinjamNada/endpoints/endpoints.dart'; // import UserCubit

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late UserCubit _userCubit;

  @override
  void initState() {
    super.initState();
    // Initialize _userCubit from context
    _userCubit = BlocProvider.of<UserCubit>(context);

    // Ensure data is fetched when the screen is initialized
    context.read<InstrumentsCubit>().fetchExcludingUser(userId: _userCubit.state.userID);
  }

  Future<void> _refreshData() async {
    // Trigger the fetch function in the InstrumentsCubit to refresh data
    await context.read<InstrumentsCubit>().fetchExcludingUser(userId: _userCubit.state.userID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<InstrumentsCubit, InstrumentsState>(
        builder: (context, state) {
          if (state.instruments.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else {
            return RefreshIndicator(
              onRefresh: _refreshData,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
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
                          SizedBox(width: 16),
                          DropdownButton<String>(
                            icon: Icon(Icons.arrow_drop_down),
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
                            hint: Text('Filter'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.instruments.length,
                      itemBuilder: (context, index) {
                        var instrument = state.instruments[index];
                        return Padding(
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
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: FadeInImage.assetNetwork(
                                          placeholder: 'assets/images/placeholder.png',
                                          image: '${Endpoints.staticImage}/${instrument.image}',
                                          fit: BoxFit.cover,
                                          width: 100,
                                          height: 100,
                                          imageErrorBuilder: (context, error, stackTrace) {
                                            return Image.asset(
                                              'assets/images/placeholder.png',
                                              fit: BoxFit.cover,
                                              width: 100,
                                              height: 100,
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Pemilik: ${instrument.ownerUsername}',
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              'Lokasi: ${instrument.location}',
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              'Deskripsi: ${instrument.description}',
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 16),
                              ],
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
