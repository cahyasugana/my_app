part of 'loan_cubit.dart';

@immutable
class LoanState {
  final List<Instruments>? loanInstruments;

  const LoanState({
    required this.loanInstruments,
  });
}

class LoanInitial extends LoanState {
  const LoanInitial() : super(loanInstruments: const []);
}
