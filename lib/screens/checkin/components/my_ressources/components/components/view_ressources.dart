import 'package:flutter/material.dart';
import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:run_your_life/widgets/appbar.dart';
import 'package:run_your_life/widgets/materialbutton.dart';
import 'package:run_your_life/widgets/slider_handler.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:run_your_life/utils/palettes/app_colors.dart';

class ViewRessources extends StatefulWidget {
  @override
  _ViewRessourcesState createState() => _ViewRessourcesState();
}

class _ViewRessourcesState extends State<ViewRessources> {
  final AppBars _appBars = new AppBars();
  final Materialbutton _materialbutton = new Materialbutton();
  final controller = PdfViewerController();
  bool _isReadable = false;
  final PanelController _panelController = new PanelController();
  double _range = 1;
  AutoScrollController autoScrollController = new AutoScrollController();
  AutoScrollController mainautoScrollController = new AutoScrollController();
  bool _isShowAppbar = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _isShowAppbar ? _appBars.whiteappbar(context, title: "TITRE DE LA RESSOURCE",) : null,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: SlidingUpPanel(
            controller: _panelController,
            maxHeight: 280,
            minHeight: 70,
            onPanelOpened: (){
              setState(() {
                _isShowAppbar = true;
              });
            },
            onPanelClosed: (){
              setState(() {
                _isShowAppbar = false;
              });
            },
            panel: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Container(
                    child: PdfDocumentLoader.openAsset(
                      'assets/pdfs/Guide_des_macros_-Angelique-Lasserre_1.pdf',
                      documentBuilder: (context, pdfDocument, pageCount) =>
                          LayoutBuilder(
                        builder: (context, constraints) => ListView(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          controller: autoScrollController,
                          scrollDirection: Axis.horizontal,
                          children: [
                            for (int x = 0; x < pageCount; x++) ...{
                              AutoScrollTag(
                                key: ValueKey(x),
                                index: x,
                                controller: autoScrollController,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            _isShowAppbar = false;
                                          });
                                          mainautoScrollController
                                              .scrollToIndex(x,
                                                  preferPosition:
                                                      AutoScrollPosition.middle,
                                                  duration: Duration(
                                                      milliseconds: 10));
                                          _panelController.close();
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColors.appmaincolor
                                                      .withOpacity(0.1)),
                                              color: Colors.grey[300],
                                            ),
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: PdfPageView(
                                              pdfDocument: pdfDocument,
                                              pageNumber: x + 1,
                                            )),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    x == 0
                                        ? SizedBox(
                                            height: 15,
                                          )
                                        : Text(
                                            (x).toString(),
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.appmaincolor,
                                                fontFamily: "AppFontStyle"),
                                          ),
                                  ],
                                ),
                              )
                            }
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    color: Colors.white,
                    child: SliderHandler(
                      onslidecallback: (double value) {},
                      range: _range,
                      onDragging: (int x, lowerValue, highestValue) {
                        _range = lowerValue;
                        autoScrollController.scrollToIndex(_range.floor(),
                            preferPosition: AutoScrollPosition.middle,
                            duration: Duration(milliseconds: 10));
                      },
                    ),
                  ),
                ),
              ],
            ),
            collapsed: InkWell(
              onTap: () {
                _panelController.open();
                setState(() {
                  _isShowAppbar = true;
                });
              },
              child: Container(
                  width: double.infinity,
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 7,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1000),
                          color: Colors.grey.shade400,
                        ),
                      ),
                      Text("Glisser vers le haut",style:  TextStyle(fontFamily: "AppFontStyle",color: AppColors.appmaincolor),)
                    ],
                  )),
            ),
            body: Column(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _panelController.close();
                      setState(() {
                        _isShowAppbar = false;
                      });
                    },
                    child: InteractiveViewer(
                      minScale: 0.5,
                      maxScale: 10,
                      child: PdfDocumentLoader.openAsset(
                        'assets/pdfs/Guide_des_macros_-Angelique-Lasserre_1.pdf',
                        documentBuilder: (context, pdfDocument, pageCount) =>
                            LayoutBuilder(
                          builder: (context, constraints) => ListView(
                            controller: mainautoScrollController,
                            padding: EdgeInsets.all(0),
                            scrollDirection: Axis.horizontal,
                            children: [
                              for(int x = 0; x < pageCount; x++)...{
                                AutoScrollTag(
                                  key: ValueKey(x),
                                  index: x,
                                  controller: mainautoScrollController,
                                  child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height,
                                      child: PdfPageView(
                                        pdfDocument: pdfDocument,
                                        pageNumber: x + 1,
                                      )),
                                ),
                              }
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 70,
                )
              ],
            ),
          ),
        ));
  }
}
