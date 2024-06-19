import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:my_app/PinjamNada/dto/Instrument.dart';
import 'package:my_app/PinjamNada/services/data_service.dart';

part 'loan_state.dart';

class LoanCubit extends Cubit<LoanState> {
  LoanCubit() : super(LoanInitial());

  //METHOD HERE
  Future<void> fetchLoans({required int userId}) async {
    try {
      debugPrint("Fetching all request & borrowed: $userId");

      List<Instruments>? loanInstruments =
          await DataService.fetchLoans(userId);
      emit(LoanState(loanInstruments: loanInstruments));
    } catch (e) {
      debugPrint("Error fetching instruments: $e");
      return null;
      // Handle error if needed
    }
  }

  void logout() {
    emit(const LoanState(loanInstruments: const[]));
  }
}
