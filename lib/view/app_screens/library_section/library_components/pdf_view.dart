import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simap/res/app_colors.dart';
import 'package:simap/view/widgets/app_custom_text.dart';

class PDFScreen extends StatefulWidget {
  final String bookTitle;
  final String url = "http://www.pdf995.com/samples/pdf.pdf"; // PDF URL

  PDFScreen({Key? key, required this.bookTitle}) : super(key: key);

  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';
  String? localFilePath;

  @override
  void initState() {
    super.initState();
    downloadAndSavePDF();
  }

  // Function to download and save the PDF
  Future<void> downloadAndSavePDF() async {
    try {
      // Get the temporary directory
      final dir = await getTemporaryDirectory();
      final filePath = '${dir.path}/sample.pdf';

      // Download the PDF using dio
      final response = await Dio().download(widget.url, filePath);

      if (response.statusCode == 200) {
        setState(() {
          localFilePath = filePath; // Save the local path to the state
        });
      } else {
        setState(() {
          errorMessage = 'Failed to download PDF';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: CustomText(text:widget.bookTitle,size: 16,color: AppColors.black,weight: FontWeight.w600,),

      ),
      body: localFilePath != null
          ? Stack(
              children: <Widget>[
                PDFView(
                  filePath: localFilePath,
                  // Load the PDF from local path
                  enableSwipe: true,
                  swipeHorizontal: true,
                  autoSpacing: false,
                  pageFling: true,
                  pageSnap: true,
                  defaultPage: currentPage!,
                  fitPolicy: FitPolicy.BOTH,
                  preventLinkNavigation: false,
                  // Disable link navigation
                  onRender: (_pages) {
                    setState(() {
                      pages = _pages;
                      isReady = true;
                    });
                  },
                  onError: (error) {
                    setState(() {
                      errorMessage = error.toString();
                    });
                    print(error.toString());
                  },
                  onPageError: (page, error) {
                    setState(() {
                      errorMessage = '$page: ${error.toString()}';
                    });
                    print('$page: ${error.toString()}');
                  },
                  onViewCreated: (PDFViewController pdfViewController) {
                    _controller.complete(pdfViewController);
                  },
                  onPageChanged: (int? page, int? total) {
                    print('page change: $page/$total');
                    setState(() {
                      currentPage = page;
                    });
                  },
                ),
                errorMessage.isEmpty
                    ? !isReady
                        ? Center(child: CircularProgressIndicator())
                        : Container()
                    : Center(child: Text(errorMessage)),
              ],
            )
          : Center(child: CircularProgressIndicator()),
      // Show loader until the PDF is downloaded
      // floatingActionButton: FutureBuilder<PDFViewController>(
      //   future: _controller.future,
      //   builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
      //     if (snapshot.hasData) {
      //       return FloatingActionButton.extended(
      //         label: Text("Go to ${pages! ~/ 2}"),
      //         onPressed: () async {
      //           await snapshot.data!.setPage(pages! ~/ 2);
      //         },
      //       );
      //     }
      //     return Container();
      //   },
      // ),
    );
  }
}
