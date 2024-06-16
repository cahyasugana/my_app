part of 'instruments_cubit.dart';

@immutable
class InstrumentsState {
  final List<Instruments> instruments;

  const InstrumentsState({
    required this.instruments,
  });
}

class InstrumentsInitial extends InstrumentsState {
  InstrumentsInitial()
      : super(instruments: const[]);
}
