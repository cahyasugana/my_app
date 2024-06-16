import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:my_app/PinjamNada/dto/Instrument.dart';
import 'package:my_app/PinjamNada/services/data_service.dart';

part 'instruments_state.dart';

class InstrumentsCubit extends Cubit<InstrumentsState> {
  InstrumentsCubit() : super(InstrumentsInitial());

  Future<void> fetchExcludingUser({required int userId}) async {
    try {
      debugPrint("Fetching instruments excluding user with ID: $userId");

      List<Instruments>? instruments =
          await DataService.fetchExcludingUser(userId);
      emit(InstrumentsState(instruments: instruments));
    } catch (e) {
      debugPrint("Error fetching instruments: $e");
      // Handle error if needed
    }
  }

  Future<void> fetchAllInstruments() async {
    try {
      debugPrint("Fetching all instruments");

      List<Instruments>? instruments =
          await DataService.fetchAllAvailableInstruments();
      emit(InstrumentsState(instruments: instruments));
    } catch (e) {
      debugPrint("Error fetching instruments: $e");
      // Handle error if needed
    }
  }
}
