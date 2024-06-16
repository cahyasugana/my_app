part of 'my_instruments_cubit.dart';

@immutable
class MyInstrumentsState {
  final List<Instruments> instruments;

  MyInstrumentsState({
    required this.instruments,
  });
}

final class MyInstrumentsInitial extends MyInstrumentsState {
  MyInstrumentsInitial()
      : super(instruments: const[]);
}
