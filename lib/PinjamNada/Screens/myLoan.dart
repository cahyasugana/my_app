import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/PinjamNada/cubit/loan/loan_cubit.dart';
import 'package:my_app/PinjamNada/cubit/user/user_cubit.dart';
import 'package:my_app/PinjamNada/endpoints/endpoints.dart';
import 'package:my_app/PinjamNada/services/data_service.dart';

class MyLoan extends StatefulWidget {
  const MyLoan({Key? key}) : super(key: key);

  @override
  _MyLoanState createState() => _MyLoanState();
}

class _MyLoanState extends State<MyLoan> {
  late UserCubit _userCubit;
  late DataService _dataService;

  @override
  void initState() {
    super.initState();
    _userCubit = BlocProvider.of<UserCubit>(context);
    _dataService = DataService();
    context.read<LoanCubit>().fetchLoans(userId: _userCubit.state.userID);
  }

  Future<void> _refreshData() async {
    await context.read<LoanCubit>().fetchLoans(userId: _userCubit.state.userID);
  }

  Future<void> _cancelLoanRequest(int requesterId, int requestId) async {
    try {
      await _dataService.cancelLoanRequest(requesterId, requestId);
      _refreshData();
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to cancel loan request')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoanCubit, LoanState>(
        builder: (context, state) {
          if (state.loanInstruments == null) {
            return Center(child: CircularProgressIndicator());
          } else if (state.loanInstruments!.isEmpty) {
            return Center(child: Text('No loan instruments available'));
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
                      itemCount: state.loanInstruments!.length,
                      itemBuilder: (context, index) {
                        var instrument = state.loanInstruments![index];
                        Color cardColor;
                        if (instrument.availabilityStatus == 1) {
                          cardColor = Colors.red[100]!;
                        } else if (instrument.availabilityStatus == 2) {
                          cardColor = Colors.yellow[100]!;
                        } else {
                          cardColor = Colors.white;
                        }
                        return GestureDetector(
                          onTap: () {
                            // Handle the tap event here
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: cardColor,
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
                                              debugPrint(error.toString());
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
                                              if (instrument.availabilityStatus == 2)
                                                ElevatedButton(
                                                  onPressed: () => _cancelLoanRequest(_userCubit.state.userID, instrument.instrumentId),
                                                  child: Text('Cancel Request'),
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.red,
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
