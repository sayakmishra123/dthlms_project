import 'dart:math';

import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:flutter/material.dart';

import 'package:showcaseview/showcaseview.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfCategory extends StatefulWidget {
  String pdf;
  PdfCategory(this.pdf, {super.key}) {
    print(pdf);
  }

  @override
  State<PdfCategory> createState() => _PdfCategoryState(pdf);
}

class _PdfCategoryState extends State<PdfCategory> {
  String pdf;
  _PdfCategoryState(this.pdf);
  // create a PdfTextSearcher and add a listener to update the GUI on search result changes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPage.bgcolor,
      // body: PdfViewer.uri(
      //   Uri.parse(
      //     'https://del1.vultrobjects.com/vgsh/DTHAdvanced/Uploads/1/pdfs/07-06-2024/99cd90ef488d4fe8bd249cf4fe0d733b.pdf',
      //   ),
      //   params: PdfViewerParams(backgroundColor: ColorPage.bgcolor),
      // ));
    );
  }
}
