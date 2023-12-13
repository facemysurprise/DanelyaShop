abstract class QrState {}

class QrInitialState extends QrState {}

class QrDisplayState extends QrState {
  final String data;
  QrDisplayState(this.data);
}