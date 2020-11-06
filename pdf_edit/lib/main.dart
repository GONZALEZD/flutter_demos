import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart' as pdf;
import 'package:pdf/widgets.dart' as pdfWidget;
import 'package:pdf_edit/pdf_editor_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Edit Pdf Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _load() async {
    PdfMutableDocument doc = await PdfMutableDocument.asset("assets/test.pdf");
    editDocument(doc);
    await doc.save(filename: "modified.pdf");
    print("PDF Edition Done");
  }

  void editDocument(PdfMutableDocument document) {
    var page = document.getPage(0);
    page.add(item: pdfWidget.Positioned(
      left: 0.0,
      top: 0.0,
      child: pdfWidget.Text("COUCOU",
          style: pdfWidget.TextStyle(fontSize: 32, color: pdf.PdfColors.red)),
    ));
    var centeredText = pdfWidget.Center(
        child: pdfWidget.Text(
      "CENTERED TEXT",
      style: pdfWidget.TextStyle(
          fontSize: 40,
          color: pdf.PdfColors.green,
          background: pdfWidget.BoxDecoration(color: pdf.PdfColors.amber)),
    ));
    page.add(item: centeredText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _load,
        tooltip: 'Load',
        icon: Icon(Icons.file_download),
        label: Text("Modify"),
      ),
    );
  }
}
