abstract class QrEvent {}

class QrScanEvent extends QrEvent {
  final String scannedData;
  QrScanEvent(this.scannedData);
}

class QrCreateEvent extends QrEvent {
  final String dataToEncode;
  QrCreateEvent(this.dataToEncode);
}