import 'package:dthlms/ThemeData/FontSize/FontSize.dart';
import 'package:dthlms/ThemeData/color/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:test_pdf_view/showpdf/showpdf.dart';
// import 'package:google_fonts/google_fonts.dart';

class PdfView extends StatefulWidget {
  const PdfView({super.key});
  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
  }

  bool get _isSliverAppBarExpanded {
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          controller: _scrollController,
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: const Color.fromRGBO(19, 23, 36, 1),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
              shape: const ContinuousRectangleBorder(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(280))),
              // show and hide SliverAppBar Title
              title: _isSliverAppBarExpanded
                  ? Text('All Online',
                      style: GoogleFonts.outfit(
                          textStyle: TextStyle(
                        // color: ColorPage.colorgrey,
                        fontSize: ClsFontsize.Small, //20
                      )))
                  : null,
              pinned: true,
              snap: false,
              floating: false,
              expandedHeight: 200,

              flexibleSpace: _isSliverAppBarExpanded
                  ? null
                  : Card(
                      elevation: 40,
                      // surfaceTintColor: Colors.red,

                      color: ColorPage.downloadbtnofvideo,
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(280))),
                      child: FlexibleSpaceBar(
                        title: Text(
                          'All Online',
                          style: TextStyle(
                              color: ColorPage.white,
                              fontWeight: FontWeight.bold,
                              fontSize: ClsFontsize.Large + 1), //25
                        ),
                        // background: Text('data'),
                      ),
                    ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: const Color.fromARGB(255, 212, 211, 211))),
                      // color: Color.fromARGB(255, 47, 47, 48),
                      child: ListTile(
                        onTap: () {},
                        leading: Image.asset(
                          'assets/file.png',
                          width: 40,
                        ),
                        title: Text(
                          overflow: TextOverflow.ellipsis,
                          'Solution infotech  pdf file.pdf ',
                          style: TextStyle(
                              fontSize: ClsFontsize.ExtraSmall,
                              fontWeight: FontWeight.w600), //14

                          // style: FontStylePage.font,
                        ),
                        subtitle: const Text(
                          '3.4 MB, pdf',
                          style: TextStyle(color: ColorPage.grey),
                        ),
                        trailing: const SizedBox(
                            width: 80,
                            child: Text(
                              'Expiry: 2025-05-13',
                              style: TextStyle(color: ColorPage.grey),
                            )),
                      ),
                    ),
                  );
                },
                childCount: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
