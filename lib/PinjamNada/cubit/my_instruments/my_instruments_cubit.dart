import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:my_app/PinjamNada/dto/Instrument.dart';
import 'package:my_app/PinjamNada/services/data_service.dart';

part 'my_instruments_state.dart';

class MyInstrumentsCubit extends Cubit<MyInstrumentsState> {
  MyInstrumentsCubit() : super(MyInstrumentsInitial());

  Future<void> fetchInstrumentsByID({required int userId}) async {
    try {
      debugPrint("Fetching instruments with user with ID: $userId");

      List<Instruments>? instruments =
          await DataService.fetchInstrumentsByID(userId);
      emit(MyInstrumentsState(instruments: instruments));
    } catch (e) {
      debugPrint("Error fetching instruments: $e");
      // Handle error if needed
    }
  }

  void logout() {
    emit( MyInstrumentsState(instruments: const[]));
  }
}
