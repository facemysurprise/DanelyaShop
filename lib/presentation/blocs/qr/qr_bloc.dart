import 'package:flutter_bloc/flutter_bloc.dart';
import 'qr_event.dart';
import 'qr_state.dart';

class QrBloc extends Bloc<QrEvent, QrState> {
  QrBloc() : super(QrInitialState()) {
    on<QrScanEvent>((event, emit) => emit(QrDisplayState(event.scannedData)));
    on<QrCreateEvent>((event, emit) => emit(QrDisplayState(event.dataToEncode)));
  }
}