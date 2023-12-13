import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nd/generated/locale_keys.g.dart';
import 'package:flutter_nd/presentation/blocs/qr/qr_bloc.dart';
import 'package:flutter_nd/presentation/blocs/qr/qr_event.dart';
import 'package:flutter_nd/presentation/blocs/qr/qr_state.dart';
import 'package:flutter_nd/presentation/pages/color.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Qr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: BlocProvider(
        create: (context) => QrBloc(),
        child: QrScannerAndGeneratorPage(),
      ),
    );
  }
}

class QrScannerAndGeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.QR_Scanner_and_Generator.tr())),
      body: QrScannerAndGeneratorView(),
    );
  }
}

class QrScannerAndGeneratorView extends StatefulWidget {
  @override
  _QrScannerAndGeneratorViewState createState() => _QrScannerAndGeneratorViewState();
}

class _QrScannerAndGeneratorViewState extends State<QrScannerAndGeneratorView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final qrTextController = TextEditingController();
  bool showScanner = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QrBloc, QrState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: showScanner ? buildQrView(context) : buildQrGenerator(context, state),
            ),
            if (!showScanner)
              Padding(
                padding: EdgeInsets.all(20),
                child: buildQrDataInput(context),
              ),
            buildToggleScannerButton(),
          ],
        );
      },
    );
  }

  Widget buildQrView(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: ColorColors.primaryColor, width: 4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: QRView(
        key: qrKey,
        onQRViewCreated: (QRViewController controller) {
          controller.scannedDataStream.listen((scanData) {
            context.read<QrBloc>().add(QrScanEvent(scanData.code ?? "No data"));
          });
        },
      ),
    );
  }

  Widget buildQrGenerator(BuildContext context, QrState state) {
    String data = (state is QrDisplayState) ? state.data : "https://example.com";

    return Center(
      child: QrImageView(
        data: data,
        version: QrVersions.auto,
        size: 200.0,
        backgroundColor: ColorColors.color11,
      ),
    );
  }

  Widget buildQrDataInput(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: qrTextController,
          decoration: InputDecoration(
            labelText: LocaleKeys.Enter_data_for_QR_Code.tr(),
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorColors.primaryColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorColors.secondaryColor),
            ),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorColors.primaryColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          ),
          onPressed: () {
            context.read<QrBloc>().add(QrCreateEvent(qrTextController.text));
          },
          child: Text(LocaleKeys.Generate_QR_Code.tr()),
        ),
      ],
    );
  }

  Widget buildToggleScannerButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: FloatingActionButton(
        backgroundColor: ColorColors.primaryColor,
        child: Icon(showScanner ? Icons.qr_code : Icons.camera_alt, color: ColorColors.color11),
        onPressed: () {
          setState(() {
            showScanner = !showScanner;
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    qrTextController.dispose();
    super.dispose();
  }
}